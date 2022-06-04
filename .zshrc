# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export NODE_REPL_HISTORY_FILE="$HOME/.noderepl-history"

# Zsh themes
ZSH_THEME="robbyrussell"

# Zsh plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# if vscode is available use that as the default editor
if command -v code &> /dev/null; then
  export EDITOR='code -w'
else 
  export EDITOR='vim'
fi

# Command to reload
reload(){
    . ~/.zshrc
}

# recent-branches is a cli to list out recent branches
# checked out to in git.
recent-branches() {
  COMMAND=$1
  INDEX=$2

  # get branches
  RESP="$(git for-each-ref --count=10 --sort=-committerdate --format='%(refname:short)' refs/heads/)"

  # checkout a recent branch
  if [[ $COMMAND == "checkout" ]] then
    # make array
    ARR=()
    while read -r LINE; do
      ARR+=("$LINE")
    done <<< "$RESP"

    if [[ -z $INDEX ]] then
      echo "Please specify a 1 based index to checkout to";
    else
      git checkout ${ARR[ INDEX + 1 ]}
    fi
    return
  fi
  # show list need to add indexs
  echo "$RESP"
}


alias current-branch="git rev-parse --abbrev-ref HEAD"

# take it to the limit
ulimit -n 1024
ulimit -u 1024

#Node Version Manager/User
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

