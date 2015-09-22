# Path to your oh-my-zsh installation.
export ZSH=/Users/jlowe/.oh-my-zsh
export NODE_REPL_HISTORY_FILE=/Users/jlowe/.noderepl-history

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="$PATH:$HOME/Users/jlowe/.rvm/gems/ruby-2.2.0/bin:/Users/jlowe/.rvm/gems/ruby-2.2.0@global/bin:/Users/jlowe/.rvm/rubies/ruby-2.2.0/bin:/Users/jlowe/.rvm/bin:/Users/jlowe/.nvm/versions/io.js/v1.2.0/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

reload(){
    . ~/.zshrc
}

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

feature() {
	FLOWCMD=$1
	FEATURE=$2
	CURRENTFEATURE=`current-feature`

	if [[ -z $FEATURE ]]
	then
		FEATURE=$CURRENTFEATURE
	fi

	if [[ $FLOWCMD == "start" ]]
	then
		git flow feature start $FEATURE
	elif [[ $FLOWCMD == "publish" ]]
	then
		git flow feature publish $FEATURE
	elif [[ $FLOWCMD == "finish" ]]
	then
		git flow feature finish $FEATURE
	else
		echo "What the hell are you doing? Get shit done by using 'feature [start|publish|finish] name'"
	fi
}

resize-speaker-photos(){
	FILEEXT=$2
	if [ -z "$FILEEXT" ]
	then
		FILEEXT="jpg"
	fi
	convert public/images/speakers/$1.$FILEEXT -resize 160x160^ -gravity center -background \#FFFFFF -extent 160x160 public/images/speakers/$1.jpg
}

current-feature() {
	BRANCHPREFIX="feature/"
	REPLACEMENT=""
	CURRENT=`current-branch`
	echo ${CURRENT/$BRANCHPREFIX/$REPLACEMENT}
}

alias current-branch="git rev-parse --abbrev-ref HEAD"

# take it to the limit
ulimit -n 1024
ulimit -u 1024

#Node Version Manager/User
export NVM_DIR="/Users/jlowe/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# For android react native ish
export ANDROID_HOME=/usr/local/opt/android-sdk
