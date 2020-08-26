# set the prompt (This must be written in .bashrc)
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]]\[\033[1;31m\]$(__git_ps1)\[\033[0m\] \$ '

# set the default editor
export EDITOR=vim
