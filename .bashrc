# Default editor
export EDITOR=vim

# PATH
export PATH=$PATH:$HOME/.bin

# asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

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
