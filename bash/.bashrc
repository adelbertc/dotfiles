if [ ${__git_ps1} ]; then
  PS1='\w$(__git_ps1 " [%s]") λ '
else
  PS1='\w λ '
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
if [ ${OSTYPE} == "darwin"* ]; then
  export HOMEBREW_NO_ANALYTICS=1
  export TERM="xterm-256color"
fi
