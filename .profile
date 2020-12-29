# Default editor
export EDITOR=vim

# Linuxbrew
if [ -x '/home/linuxbrew/.linuxbrew/bin/brew' ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/isl@0.18/lib"
  export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/isl@0.18/include"
fi

# Keychain
if [ -x '/home/linuxbrew/.linuxbrew/bin/keychain' ]; then
  /home/linuxbrew/.linuxbrew/bin/keychain --nogui $HOME/.ssh/id_rsa
  source $HOME/.keychain/$HOSTNAME-sh
fi

# asdf
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

# Prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]]\[\033[1;31m\]$(__git_ps1)\[\033[0m\] \$ '
