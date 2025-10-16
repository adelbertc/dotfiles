PS1='\[\e[0;36m\]\w\[\e[0;32m\]$(maybeGitBranch) \[\e[0;31m\]$ \[\e[0m\]'

maybeGitBranch () {
  local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/')

  if [[ -n $branch ]]; then
    if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
      echo -e "\001\033[32m\002$branch\001\033[0m\002"
    else
      echo -e "\001\033[31m\002$branch\001\033[0m\002"
    fi
  fi
}

# Colors for LS and Grep
export CLICOLOR=1 # LS Color
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

export PATH=~/.scripts:$PATH

[[ -d ~/.scripts/private ]] && export PATH=~/.scripts/private:$PATH

export EDITOR=vim

set -o vi

# ------------------------------------------------------
#            Command Aliases / Functions
# ------------------------------------------------------

# ------------------------------------------------------
#            macOS Only
# ------------------------------------------------------
if [[ "${OSTYPE}" == "darwin"* ]]; then
  export BASH_SILENCE_DEPRECATION_WARNING=1
  export HOMEBREW_NO_ENV_HINTS=1

  eval "$(/opt/homebrew/bin/brew shellenv)"
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
fi

# Source local .bash_private if it exists
[[ -f ~/.bash_private ]] && source "${HOME}/.bash_private"
