PS1='\w$(__git_ps1 " : %s")\nlocal ☯ '

alias grep="grep --color=auto"

alias ls="ls -GF"

alias tma="tmux attach -t"

export EDITOR="nvim"

export TERM="xterm-256color"

set -o vi

# Source local bashrc if it exists
if [ -f ./.bashrc_aux ]; then
    . ./.bashrc_aux
fi
