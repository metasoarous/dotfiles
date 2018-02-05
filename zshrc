
# Local early bird overrides, modifications
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local


autoload -U colors && colors
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


# Theme to load - Look in ~/.oh-my-zsh/themes/ or set to "random"
#ZSH_THEME="gnzh"
#ZSH_THEME="agnoster" # Nice boldly-colored line highlighters, but needs special font
ZSH_THEME="random"
# awesomepanda - nice and simple; bold so sticks out fairly well, but not as well as agnoster
# crcandy - very nice; time, bold, git, location, server, user, simple prompt. Like it; could be more boldy
#ZSH_THEME=crcandy
#ZSH_THEME=tonotdo
ZSH_THEME=re5et
# colored though
#


# Otherwise fucks with tmux window naming
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

# Enables autojump ocation to be overridden on a local basis - need for fhcrc servers
autojump=/usr/share/autojump/autojump.zsh

# Main path list. Can be added to with ~/.zshrc.local
#export PATH=/usr/local/bin:/app/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/sbin

[[ -s /home/matsengrp ]] && export R_LIBS_SITE=~matsengrp/local/R-packages
export ENTREZ_EMAIL=csmall@fhcrc.org
#export PATH=/usr/local/bin:$HOME/.linuxbrew/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/sbin:/app/bin
export PATH=/usr/local/bin:$HOME/.linuxbrew/bin:/app/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/sbin:$PATH

export PATH=$HOME/local/bin:$HOME/bin:$HOME/Dropbox/bin:$PATH

# Load oh my zsh
source $ZSH/oh-my-zsh.sh


# I've decided maybe autocorrection IS maybe more trouble than worth...
unsetopt correct_all

# Ocaml dev settings
export OCAMLRUNPARAM=b

# Load rvm if present
[[ -s "/home/$USER/.rvm/scripts/rvm" ]] && source "/home/$USER/.rvm/scripts/rvm" 
# Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin

# Sets diff to colordiff if present
which colordiff > /dev/null && alias diff="colordiff"

# These are from http://www.f30.me/2012/10/oh-my-zsh-key-bindings-on-ubuntu-12-10/
# Solves no up-line-or-search functionality from oh-my-zsh. Try removing periodically. Appears to be a cleaner
# patch which may be going to omzsh - XXX
#bindkey "${terminfo[kcuu1]}" up-line-or-search
#bindkey "${terminfo[kcud1]}" down-line-or-search

# This is disables the Ctrl-S Xoff feature of the shell
stty -ixon

# Trying to increase the number of history items
HISTSIZE=100000
SAVEHIST=100000

# A few settings for my cheat sheets 
export EDITOR='/usr/bin/gvim -v'
alias vim='gvim -v'
export CHEATCOLORS=true

# alias git to hub
#eval "$(hub alias -s)"


# ALIASES!!!!!!!!!!
# =================

# Listing aliases
alias ll='ls -hl'
alias la='ls -hla'
alias lat='ls -hlat'
alias wdid='ls -chlt | head'
alias l='ls -hl'
alias lt='ls -hlt'
alias files='nautilus'
alias tmux="TERM=screen-256color-bce tmux -2"
alias duh='du -hs'
alias less='TERM=xterm less -R'
alias svim='/usr/bin/vim' # since matsengrp vim doesn't seem to work on 1404

# quick zsh mods
alias rrc='source ~/.zshrc'
alias erc='vim ~/.zshrc'

# Other
alias ack='ack-grep'
alias xc='xclip -selection clip'
alias xp='xclip -selection clip -o'
alias sc='scons --debug explain'
alias scn='scons -n --debug explain'
alias evrc='vim ~/.vimrc'
alias sm='seqmagick'
alias smi='seqmagick info'
alias smc='seqmagick convert'
alias seqconv='seqmagick convert'
alias seqinfo='seqmagick info'
alias seqids='seqmagick extract-ids'
alias ccat='source-highlight -fesc -o STDOUT'
alias rtmc='rtm -c'

# removing bad dos carriage returns (mother fuckers)
alias dos2unix2="tr '\r' '\n' <"

LEIN_JAVA_CMD=/usr/local/bin/drip


# run batches of jobs with salloc
sca() {
  salloc -n $1 scons --debug explain -j $@
}


# Archeopterix helper
aptx() {
  java -jar ~/bin/forester.jar -c ~/.aptxrc $1
}

# Reload shell
r () {
  # Reload X tunells if in tmux
  if [[ -n $TMUX ]]
  then
    NEW_SSH_AUTH_SOCK=`tmux showenv|grep "^SSH_AUTH_SOCK"|cut -d = -f 2` 
    if [[ -n $NEW_SSH_AUTH_SOCK ]] && [[ -S $NEW_SSH_AUTH_SOCK ]]
    then
      echo "New auth sock: $NEW_SSH_AUTH_SOCK"
      SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK 
    fi
    NEW_DISPLAY=`tmux showenv|grep "^DISPLAY"|cut -d = -f 2` 
    if [[ -n $NEW_DISPLAY ]]
    then
      echo "New display: $NEW_DISPLAY"
      DISPLAY=$NEW_DISPLAY 
    fi
  fi
  # Reload shell rc
  rrc  
}

# Readlink piped to xclip...
rl () {
  if [[ -n $1 ]]
  then
    p=$1
  else
    p='.'
  fi
  readlink -f $p
}
rlxc () {
  rl $1 | xc
}

# CSVKIT stuffs
csvless () {
  csvlook $1 | less -S
}
tsvless () {
  csvlook -t $1 | less -S
}
csvhead () {
  head $@ | csvlook
}
csvtail () {
  htail $@ | csvlook
}

addcol () {
  csvstack -n $2 -g $3,nul $1 /dev/null
}

# Similarly, for json
alias jsonlook='python -mjson.tool'
jsonless () {
  jsonlook $@ | less -S
}
jsonhead () {
  jsonlook $@ | head
}

htail () {
  if [[ ! -n $2 ]]
  then
    n=10
  else
    n=$2
  fi
  head -n 1 $1
  tail -n $n $1
}

avxless () {
  av -L 99999 -w 99999 -cx $@ | less -S
}
avless () {
  av -L 99999 -w 99999 -c $@ | less -S
}

alias avlook='av -L 10000 -w 10000 -c'
alias avlook='av -L 10000 -w 10000 -cx'

waid () {
  ps ux --sort s | less -S
}

# Markdown converters
md2html () {
  for i in $@
  do
    pandoc $i -s --css "http://matsen.fhcrc.org/webpage.css" -o $(basename $i .md).html
  done
}
md2slidy () {
  for i in $@
  do
    pandoc $i -s --css "http://matsen.fhcrc.org/webpage.css" --to=slidy -o $(basename $i .md).html
  done
}
pdfjoin () {
  pdftk $@ cat output joined.pdf
  print "Joined pdf saved to joined.pdf!"
}



bindkey '\e.' insert-last-word

# For when my clutsy ass forgets to add things to a git commit
forgitadd () {
  git reset --soft HEAD~1
  git add .
  git commit -c ORIG_HEAD
}


# Supposed to clip out the stderr; doesn't quite work yet...
alias stderrxc='2>&1 > /dev/null | xc'


# For evil deeds...
hdoze () {
  if [[ -n $1 ]]
  then
    # Only parameter (optional) is height
    height=$1
  else
    # Default window height is...
    height=`xdpyinfo | grep dimensions | sed "s/.*[0-9]*x\([0-9]*\) pixels.*/\1/"`
    ((height=$height - 120))
  fi
  rdesktop -u fhcrc\\csmall -d FHCRC cbio-csmall.fhcrc.org -K -T "SHitB@rF" -g 1450x$height &
}


# auto jump !
[[ -s $autojump ]] && . $autojump && autoload -U compinit && compinit

# Stuff for virtual env to be prettier
#export VIRTUAL_ENV_DISABLE_PROMPT=1
#function virtualenv_info() {
  #if [ ! -z "$VIRTUAL_ENV" ]; then
    #echo "(${VIRTUAL_ENV:t}) "
  #fi
#}
#PROMPT="$PROMPT$(virtualenv_info)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Activate pythedge environment if present
#[[ -s $HOME/pythedge-clstr/bin/activate ]] && source $HOME/pythedge-clstr/bin/activate

# If anything needs to be modified after everything has run
[[ -s $HOME/.zshrc.local.after ]] && source $HOME/.zshrc.local.after



export NVM_DIR="/home/csmall/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
