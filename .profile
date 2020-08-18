# set the prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export PS1='[\[\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\] \[\033[0;33m\]\w\[\033[0m\]]\[\033[1;31m\]$(__git_ps1)\[\033[0m\] \$ '

# set the default editor
export EDITOR=vim

# set the default pager
export PAGER=less

# set PATH
export PATH=${PATH}:${HOME}/bin
