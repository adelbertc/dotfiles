PS1='\w$(__git_ps1 " : %s")\nlocal ☯ '

alias grep="grep --color=auto"

alias ls="ls -GF"

alias tma="tmux attach -t"

export EDITOR="nvim"

export TERM="xterm-256color"

set -o vi

# Source local bashrc if it exists
CURRENT_DIR=${HOME}
AUX_FILE=.bashrc_aux
AUX_FILE_PATH=${CURRENT_DIR}/${AUX_FILE}

if [ -f ${AUX_FILE_PATH} ]; then
  . ${AUX_FILE_PATH}
fi
