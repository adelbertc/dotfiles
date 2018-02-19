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

emacs_cmd="emacsclient --quiet --alternate-editor=nvim"

if hash emacsclient 2>/dev/null; then
  export EDITOR="${emacs_cmd}"
elif hash nvim 2>/dev/null; then
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
  alias e="${emacs_cmd}"

  # Start Emacs in a shell named 'shell'
  emacs_shell="/bin/bash"
  emacs_shell_name="shell"
  alias emacs="open ~/.nix-profile/Applications/Emacs.app --args --eval '(ansi-term \"${emacs_shell}\" \"${emacs_shell_name}\")'"
fi

# Source local .bash_private if it exists
[[ -f ~/.bash_private ]] && source ~/.bash_private
