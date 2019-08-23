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

export PATH=~/.config/personal_scripts:$PATH

alias nvim="echo 'Use emacs you coward.'"
term_emacs_nw="~/.nix-profile/Applications/Emacs.app/Contents/MacOS/Emacs -nw"
term_emacs="TERM=xterm emacsclient -nw --alternate-editor=\${term_emacs_nw}"
alias e=${term_emacs}

if hash emacsclient 2>/dev/null; then
  export EDITOR="${term_emacs}"
else
  export EDITOR=vim
fi

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
[[ -f ~/.bash_private ]] && source ~/.bash_private
