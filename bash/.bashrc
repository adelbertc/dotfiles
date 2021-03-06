PS1='\[\e[0;36m\]\w\[\e[0;32m\]$(maybeGitBranch) \[\e[0;31m\]☯  \[\e[0m\]'

maybeGitBranch () {
  if hash __git_ps1 2>/dev/null; then
    __git_ps1 " [%s]"
  else
    echo ""
  fi
}

# Colors for LS and Grep
export CLICOLOR=1 # LS Color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export PATH=~/.scripts:$PATH

[[ -d ~/.scripts/private ]] && export PATH=~/.scripts/private:$PATH

export EDITOR=vim
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

set -o vi

# ------------------------------------------------------
#            Command Aliases / Functions
# ------------------------------------------------------

# ------------------------------------------------------
#            macOS Only
# ------------------------------------------------------
if [[ "${OSTYPE}" == "darwin"* ]]; then
  alias emacs="open -a ~/.nix-profile/Applications/Emacs.app --args"
fi

# Source local .bash_private if it exists
[[ -f ~/.bash_private ]] && source "${HOME}/.bash_private"
