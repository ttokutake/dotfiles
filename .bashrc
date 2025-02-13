# Default editor
export EDITOR=vim

# PATH
PATH=$PATH:$HOME/.bin

# mise
eval "$(~/.local/bin/mise activate bash)"

# Bash Completion
if [ -f "/etc/profile.d/bash_completion.sh" ]; then
  . "/etc/profile.d/bash_completion.sh"
  # Prompt
  export PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]]\[\033[1;31m\]$(__git_ps1)\[\033[0m\] \$ '
  export GIT_PS1_SHOWDIRTYSTATE=true
  export GIT_PS1_SHOWUNTRACKEDFILES=true
  export GIT_PS1_SHOWSTASHSTATE=true
else
  # Prompt
  export PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]] \$ '
fi

# keychain
if [ -x "$(which keychain)" ]; then
  /usr/bin/keychain -q --nogui $HOME/.ssh/id_ed25519
  source $HOME/.keychain/$NAME-sh
fi
