#   ____  ____   ___  _____ ___ _     _____ 
#  |  _ \|  _ \ / _ \|  ___|_ _| |   | ____|
#  | |_) | |_) | | | | |_   | || |   |  _|  
#  |  __/|  _ <| |_| |  _|  | || |___| |___ 
#  |_|   |_| \_\\___/|_|   |___|_____|_____|
#                                           


#
# For startup time debugging, enable the next line:
#
#PS4=$'+ %D{%s.%6.} %N:%i> '
# 
# and execute this:
#
#zsh -lx 2>zsh-startup.log
#
# after that finishes, execute "exit"


#   _________  _   _ 
#  |__  / ___|| | | |
#    / /\___ \| |_| |
#   / /_ ___) |  _  |
#  /____|____/|_| |_|
#                    

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
plugins=(autojump sudo docker zsh-autosuggestions derp yarn-autocompletions) 

ZSH_THEME="bullet-train"
BULLETTRAIN_STATUS_EXIT_SHOW=true

COMPLETION_WAITING_DOTS="true"

source $ZSH/oh-my-zsh.sh

export HISTFILE=~/.zsh_history        # ensure history file visibility
export HH_CONFIG=hicolor,keywords     # get more colors
bindkey -s "\C-r" "\eqhh\n"           # bind hh to Ctrl-r (for Vi mode check doc)


# Just writing "." will reload zshrc
function _accept-line() {
    if [[ $BUFFER == "." ]]; then
        BUFFER="source ~/.zshrc"
    fi
    zle .accept-line
}

zle -N accept-line _accept-line

#      _    _     ___    _    ____  _____ ____  
#     / \  | |   |_ _|  / \  / ___|| ____/ ___| 
#    / _ \ | |    | |  / _ \ \___ \|  _| \___ \ 
#   / ___ \| |___ | | / ___ \ ___) | |___ ___) |
#  /_/   \_\_____|___/_/   \_\____/|_____|____/ 
#                                               

alias ..="cd .."
alias dir="ls -lA --color=yes"
alias cd..="cd .."
alias please='sudo $(fc -nl -1)'
alias fuck='sudo $(fc -nl -1)'
alias pm2="node_modules/.bin/pm2"

function ssh_connect() {
  if [ "$#" -eq 0 ]; then
    cat ~/.ssh_targets > ~/.ssh_temp
    printf "\n" >> ~/ssh_temp
    cat ~/.zsh_history | grep ":0;sscc" >> ~/.ssh_temp
    HISTFILE=~/.ssh_temp hh
    return 0
  fi
  LINE="ssh $@"
  FILE="$HOME/.ssh_targets"
  /usr/bin/ssh "$@"
  if [ $? -eq 0 ]; then
    grep -q -F "$LINE" $FILE || echo ": $(date +%s):0;$LINE" >> $FILE
  fi
    
}
alias ssh="ssh_connect"

#   ____   _  _____ _   _ ____  
#  |  _ \ / \|_   _| | | / ___| 
#  | |_) / _ \ | | | |_| \___ \ 
#  |  __/ ___ \| | |  _  |___) |
#  |_| /_/   \_\_| |_| |_|____/ 
#                               

export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH="$PATH:/usr/local/Cellar/solr/5.1.0/libexec/bin"
export PATH="$PATH:/bin"
export PATH="$PATH:/sbin"
export PATH="$PATH:/usr/bin"
export PATH="$PATH:/usr/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/usr/local/bin"
export PATH="$PATH:/opt/X11/bin"
export PATH="$PATH:/Users/ben/bin"
export PATH="$PATH:/opt/etcher-cli"
export PATH="$HOME/.yarn/bin:$PATH"
export GOOGLE_APPLICATION_CREDENTIALS="/Users/ben/.google/werkerapp.json"

export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

#   _   _ _____ ___ _     ___ _____ ___ _____ ____  
#  | | | |_   _|_ _| |   |_ _|_   _|_ _| ____/ ___| 
#  | | | | | |  | || |    | |  | |  | ||  _| \___ \ 
#  | |_| | | |  | || |___ | |  | |  | || |___ ___) |
#   \___/  |_| |___|_____|___| |_| |___|_____|____/ 
#                                                   

awsprofile() {

  if [[ -z "$1" ]]; then
    cat ~/.aws/config | grep "\[profile"
  else
    export AWS_PROFILE=$1
  fi

}

herokuapp() {

  if [[ -z "$1" ]]; then
    ls -1 ~/.heroku
    return 0
  fi

  APP="$HOME/.heroku/$1"

  if [ ! -e $APP ]; then
    echo "$APP does not exist"
  else
    export HEROKU_APP=$1
  fi
}

herokuapps() {
  herokuapp "$1"
}

dockerhost() {
  if [[ -z "$1" ]]; then
    echo DOCKER_HOST=$DOCKER_HOST
    echo 
    echo "dockerhost <new-docker-host>"
    echo
  else
    echo Setting DOCKER_HOST=$1
    export DOCKER_HOST=$1
  fi
}

gitroot() {
  cd $(git rev-parse --show-toplevel)
}

gt() {
  cd $(git rev-parse --show-toplevel)
}

setjdk() {
  export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}

setjdk 1.8

cdf() {

  target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
  if [ "$target" != "" ]; then
      cd "$target"; pwd
  else
     echo 'No Finder window found' >&2
  fi
}

#   _   _ _   _ ____   ___  ____ _____ _____ ____  
#  | | | | \ | / ___| / _ \|  _ \_   _| ____|  _ \ 
#  | | | |  \| \___ \| | | | |_) || | |  _| | | | |
#  | |_| | |\  |___) | |_| |  _ < | | | |___| |_| |
#   \___/|_| \_|____/ \___/|_| \_\|_| |_____|____/ 
#                                                  

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

setopt no_rm_star_silent

export NVM_DIR="/Users/ben/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" 

export HOMEBREW_BREWFILE="/Users/ben/Dropbox (Personal)/config/Brewfile"

if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

source ~/.zshrc.local
eval "$(pyenv init -)"
