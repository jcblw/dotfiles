# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="sorin"
ZSH_THEME="pure"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git, npm, web-search)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

# Load NVM
. $HOME/.nvm/nvm.sh

# Load RVM

## Added by the Heroku Toolbelt
## export PATH="/usr/local/heroku/bin:$PATH"
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export PYTHONPATH="$PYTHONPATH:/usr/local/lib/python2.7/site-packages"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# starts elastic search in sudo and -f runs in foreground
alias elasticsearch-server="sudo /usr/share/elasticsearch/bin/elasticsearch -f"

# custom programs
alias copy-whatididtoday="git-activity --json --me | stream-json-clipboard -k message --humanize -p'- '"
alias topnode="top -c -p $(pgrep -d',' -f node)"

# tarpipe http://blog.extracheese.org/2010/05/the-tar-pipe.html
tarpipe() {
  (cd $1 && tar -cf - .) | (cd $2 && tar -xpf -)
}

recent-branches() {
  BRANCHAMOUNT=$1
  if [ -z  "$BRANCHAMOUNT" ]
  then
    BRANCHAMOUNT=10
  fi
  git for-each-ref --count="$BRANCHAMOUNT" --sort=-committerdate --format='%(refname:short)' refs/heads/
}

resize-speaker-photos(){
  FILEEXT=$2
  if [ -z "$FILEEXT" ]
  then
    FILEEXT="jpg"
  fi
  convert public/images/speakers/$1.$FILEEXT -resize 160x160^ -gravity center -extent 160x160 public/images/speakers/$1.jpg
}

# copy a field from package.json
pkgclip() {
    cat package.json | stream-json-clipboard -k $1
}

reload(){
    . ~/.zshrc
}

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# docker stuff
alias dl='docker ps -l -q'

# added by travis gem
[ -f /home/jacob/.travis/travis.sh ] && source /home/jacob/.travis/travis.sh

#Node Version Manager
export NVM_DIR="/home/jacob/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
