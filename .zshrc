# Git Completion
autoload -Uz compinit && compinit

# Set Git Prompt
source /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
precmd () { __git_ps1 '%F{cyan}%n%f@%F{green}%m %f[%c]' ' $ ' ' (%s)' }
