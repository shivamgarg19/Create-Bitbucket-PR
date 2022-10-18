cd
rm .zshrc
cat > .zshrc <<EOF
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
export ZSH="/Users/shivamgarg/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  z
  git
  bundler
  dotenv
  macos
  zsh-autosuggestions
  last-working-dir
  web-search
  history
  sudo
)

# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
source $ZSH/oh-my-zsh.sh
source /Users/shivamgarg/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# z extension for browsing
#. ~/z.sh

# user configuration
# custom aliases
alias ll="ls -1a";
alias ..="cd ../";
alias ..l="cd ../ && ll";
alias pg="echo 'Pinging Google' && ping www.google.com";
alias de="cd ~/Desktop";
alias dd="cd ~/code";
alias d="cd ~/code && cd "
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
alias deleteDSFiles="find . -name '.DS_Store' -type f -delete"
alias npm-update="npx npm-check -u";
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

## git aliases
function gc { git commit -m "$@"; }
alias gcm="git checkout master";
alias gs="git status";
alias gpull="git pull";
alias gf="git fetch";
alias gfa="git fetch --all";
alias gf="git fetch origin";
alias gd="git diff";
alias ga="git add .";
alias gb="git branch";
alias gbr="git branch remote"
alias gfr="git remote update"
alias gbn="git checkout -B "
alias grf="git reflog";
alias grh="git reset HEAD~" # last commit
alias gac="git add . && git commit -a -m "
alias gsu="git gpush --set-upstream origin "
alias glaog="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
alias gppr="ggp && cpr"
## checkout a new remote branch (exists remote, not locally)
## git checkout -b LocalName origin/remotebranchname (checkout a remote branch)


## yarn aliases
alias yi="yarn install";
alias ys="yarn start";

## other aliases
alias zshrc='code ~/.zshrc'
alias topten="history | commands | sort -rn | head"
alias myip="curl http://ipecho.net/plain; echo"
alias dirs='dirs -v | head -10'
alias usage='du -h -d1'
alias update="source ~/.zshrc"
alias sshdir="cd ~/.ssh"
alias runp="lsof -i "
alias md="mkdir "
alias ..='cd ..'
alias ...='cd ../..'

## this loads NVM
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

commands() {
  awk '{a[$2]++}END{for(i in a){print a[i] " " i}}'
}

config_service(){
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export CLUSTER_TYPE=local
export config_type=mongo
/Users/shivamgarg/configservice/ConfigurationService/gradlew bootRun
}

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####

#ssh -L 9011:dms-tst-rds.ccm2gafxhyv5.us-west-1.rds.amazonaws.com:3306 tst-connector





 #ssh -L 9030:192.168.182.229:27017 tst-connectorsource /Users/shivamgarg/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
EOF
