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

export PATH=~/.config/personal_scripts:$PATH

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
if [[ "${OSTYPE}" == "darwin"* ]];
then
  alias e="emacsclient --alternate-editor=macos-emacs-server --create-frame"
else
  alias e="emacsclient --alternate-editor='' --create-frame"
fi

# Source local .bash_private if it exists
[[ -f ~/.bash_private ]] && source ~/.bash_private
