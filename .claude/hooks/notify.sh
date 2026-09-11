#!/usr/bin/env bash

# Claude Code hooks から呼ばれる音声通知スクリプト。
#
#   notify.sh stop           作業が終わってユーザー入力待ちになったとき（Stop hook）
#   notify.sh notification   許可待ちなどでブロックしたとき（Notification hook）
#   notify.sh quiet          再通知を止める（UserPromptSubmit / SessionEnd hook、手動実行）
#   notify.sh mute           次の stop を 1 回だけ黙らせる（作業継続中のターンで Claude が使う）
#
# 声をかけたあとは INTERVAL 秒おきに MAX_REPEAT 回まで同じ内容を繰り返す。
# 手動で止めたいときは別ターミナルかセッション内で以下を実行する。
#
#   ~/.claude/hooks/notify.sh quiet

set -uo pipefail

INTERVAL=${CLAUDE_NOTIFY_INTERVAL:-600}
MAX_REPEAT=${CLAUDE_NOTIFY_MAX_REPEAT:-6}
STATE_DIR=${CLAUDE_NOTIFY_STATE_DIR:-${TMPDIR:-/tmp}/claude-notify}

function state_file () {
  local key=${1:-default}
  echo "${STATE_DIR}/${key//[^A-Za-z0-9._-]/_}.pid"
}

function stop_one () {
  local file=$1
  [ -f "${file}" ] || return 0

  local pid=$(cat "${file}" 2>/dev/null)
  # pid が使い回されている可能性があるので、自分のプロセスであることを確かめてから落とす。
  if [ -n "${pid}" ] && ps -o command= -p "${pid}" 2>/dev/null | grep -q 'notify.sh __repeat'; then
    kill "${pid}" >/dev/null 2>&1 || true
    pkill -P "${pid}" >/dev/null 2>&1 || true
  fi
  rm -f "${file}"
}

function stop_all () {
  local file
  for file in "${STATE_DIR}"/*.pid; do
    [ -e "${file}" ] || continue
    stop_one "${file}"
  done
}

function speak () {
  local key=$1
  local message=$2

  mkdir -p "${STATE_DIR}"
  stop_one "$(state_file "${key}")"

  say "${message}" || true

  if [ "${MAX_REPEAT}" -gt 0 ]; then
    nohup "$0" __repeat "${key}" "${message}" >/dev/null 2>&1 &
    echo $! > "$(state_file "${key}")"
  fi
}

# バックグラウンドで再通知を繰り返す。stop_one に kill されるか上限に達したら終わる。
function repeat () {
  local key=$1
  local message=$2

  # sleep 中に kill されたとき、次の say に進まずその場で終わるようにする。
  trap 'rm -f "$(state_file "${key}")"; exit 0' TERM INT

  local i
  for ((i = 0; i < MAX_REPEAT; i++)); do
    sleep "${INTERVAL}"
    say "${message}" || true
  done
  rm -f "$(state_file "${key}")"
}

function json_value () {
  local key=$1
  jq -r --arg key "${key}" '.[$key] // empty' 2>/dev/null
}

# 直近のターンでツールを使ったかどうかを返す。ツールを一度も使っていないターンは
# 単なる会話の返事とみなして声をかけない。判定できないときは had_tool_use を返す。
function turn_kind () {
  local transcript=$1

  [ -n "${transcript}" ] && [ -f "${transcript}" ] || { echo had_tool_use; return; }

  tail -n 1000 "${transcript}" 2>/dev/null | jq -s -r '
    def is_prompt:
      .type == "user"
      and ((.message.content | type) == "string"
           or ((.message.content | type) == "array"
               and ([.message.content[]? | select(.type == "tool_result")] | length) == 0));
    def is_tool_use:
      .type == "assistant"
      and ([.message.content[]? | select(.type == "tool_use")] | length) > 0;

    [ .[] | select(.isSidechain != true) ]
    | reverse
    | [ .[] | if is_prompt then "prompt" elif is_tool_use then "tool" else "other" end ]
    | (index("prompt") // length) as $turn
    | if length == 0 then "had_tool_use"
      elif (.[0:$turn] | index("tool")) then "had_tool_use"
      else "conversation_only" end
  ' 2>/dev/null || echo had_tool_use
}

command -v say >/dev/null 2>&1 || exit 0

event=${1:-}
case "${event}" in
  __repeat)
    repeat "${2:-default}" "${3:-終わったよ}"
    ;;

  stop)
    input=$(cat)
    # mute されたターンは黙って通り過ぎる。
    if [ -f "${STATE_DIR}/mute" ]; then
      rm -f "${STATE_DIR}/mute"
      exit 0
    fi
    if [ "${CLAUDE_NOTIFY_ALWAYS:-0}" != 1 ]; then
      transcript=$(printf '%s' "${input}" | json_value transcript_path)
      [ "$(turn_kind "${transcript}")" = conversation_only ] && exit 0
    fi
    speak "$(printf '%s' "${input}" | json_value session_id)" '終わったよ'
    ;;

  notification)
    input=$(cat)
    # 入力待ちの通知は Stop hook と重複するので無視し、許可待ちなどにだけ反応する。
    case "$(printf '%s' "${input}" | json_value message)" in
      *'waiting for your input'*) exit 0 ;;
    esac
    speak "$(printf '%s' "${input}" | json_value session_id)" '確認して'
    ;;

  quiet)
    stop_all
    rm -f "${STATE_DIR}/mute"
    ;;

  mute)
    stop_all
    mkdir -p "${STATE_DIR}"
    touch "${STATE_DIR}/mute"
    ;;

  *)
    echo "usage: $(basename "$0") {stop|notification|quiet|mute}" >&2
    exit 2
    ;;
esac

exit 0
