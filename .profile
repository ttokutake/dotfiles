# Set the default editor
export EDITOR=vim

# Load the SSH key
if [ -x '/usr/bin/keychain' ]; then
  /usr/bin/keychain --nogui $HOME/.ssh/id_rsa
  source $HOME/.keychain/$HOSTNAME-sh
fi

# Load asfd
if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source $HOME/.asdf/asdf.sh
fi

# Load .bashrc
if [ -f "$HOME/.bashrc" ]; then
  source $HOME/.bashrc
fi

# Set the prompt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]]\[\033[1;31m\]$(__git_ps1)\[\033[0m\] \$ '
