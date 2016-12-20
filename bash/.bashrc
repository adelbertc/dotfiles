if [ -n ${__git_ps1} ] && [ -n "${SSH_CLIENT}" ]; then
  PS1='\[\e[0;36m\]\h : \w\[\e[0;32m\]$(__git_ps1 " [%s]") \[\e[0;31m\]λ \[\e[0m\]'
elif [ -n ${__git_ps1} ]; then
  PS1='\[\e[0;36m\]\w\[\e[0;32m\]$(__git_ps1 " [%s]") \[\e[0;31m\]λ \[\e[0m\]'
elif [ -n "${SSH_CLIENT}" ]; then
  PS1='\[\e[0;36m\]\h : \w \[\e[0;31m\]λ \[\e[0m\]'
else
  PS1='\[\e[0;36m\]\w \[\e[0;31m\]λ \[\e[0m\]'
fi

# Source local bashrc if it exists
[ -f ~/.bash_private ] && source ~/.bash_private

# Colors for LS and Grep
export CLICOLOR=1 # LS Color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Use (N)Vim as default editor
if hash nvim 2>/dev/null;
then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

set -o vi

# ------------------------------------------------------
#            Command Aliases / Functions
# ------------------------------------------------------
alias tma="tmux attach -t"

# ------------------------------------------------------
#            OSX Only
# ------------------------------------------------------
if [[ "${OSTYPE}" == "darwin"* ]]; then
  alias tracelinks="perl -MCwd -le 'print Cwd::abs_path(shift)'"
  export HOMEBREW_NO_ANALYTICS=1
  export TERM="xterm-256color"
fi
