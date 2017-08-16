PS1='\[\e[0;36m\]\w\[\e[0;32m\]$(maybeGitBranch) \[\e[0;31m\]⊢ \[\e[0m\]'

maybeGitBranch () {
  if hash __git_ps1 2>/dev/null; then
    echo "$(__git_ps1 " [%s]")"
  else
    echo ""
  fi
}

# Colors for LS and Grep
export CLICOLOR=1 # LS Color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

# Use (N)Vim as default editor
if hash nvim 2>/dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

set -o vi

# ------------------------------------------------------
#            Command Aliases / Functions
# ------------------------------------------------------

# ------------------------------------------------------
#            macOS Only
# ------------------------------------------------------
if [[ "${OSTYPE}" == "darwin"* ]]; then
  alias tracelinks="perl -MCwd -le 'print Cwd::abs_path(shift)'"
  export HOMEBREW_NO_ANALYTICS=1
fi

# Source local .bash_private if it exists
[[ -f ~/.bash_private ]] && source ~/.bash_private
