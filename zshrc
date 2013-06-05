autoload -U colors && colors
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


# Theme to load - Look in ~/.oh-my-zsh/themes/ or set to "random"
ZSH_THEME="duellj"

# Otherwise fucks with tmux window naming
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

# Main path list. Can be added to with ~/.zshrc.local
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin:/sbin
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
# Load oh my zsh
source $ZSH/oh-my-zsh.sh


# I've decided maybe autocorrection IS maybe more trouble than worth...
unsetopt correct_all


# Ocaml dev settings
OCAMLRUNPARAM=b


# Load rvm if present
[[ -s "/home/$USER/.rvm/scripts/rvm" ]] && source "/home/$USER/.rvm/scripts/rvm" 

# These are from http://www.f30.me/2012/10/oh-my-zsh-key-bindings-on-ubuntu-12-10/
# Solves no up-line-or-search functionality from oh-my-zsh. Try removing periodically. Appears to be a cleaner
# patch which may be going to omzsh - XXX
bindkey "${terminfo[kcuu1]}" up-line-or-search
bindkey "${terminfo[kcud1]}" down-line-or-search


# Archeopterix helper
aptx() {
  java -jar ~/bin/forester.jar -c ~/.aptxrc $1
}

# Reload X tunells if in tmux
r () {
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
}

# Easy xclipping...
xc () {
  xclip -selection clip $1
}

# Readlink piped to xclip...
rlxc () {
  readlink -f $1 | xc
}

csvless () {
  csvlook $1 | less -S
}

tsvless () {
  csvlook -t $1 | less -S
}

csvcnt () {
  csvcut -c $1 $2 | sort | uniq -c
}

tsvcnt () {
  csvcut -c $1 -t $2 | sort | uniq -c
}

csvhead () {
  head $@ | csvlook
}

csvtail () {
  htail $@ | csvlook
}

# Stuff for json!
alias jsonlook='python -mjson.tool'
jsonless () {
  jsonlook $@ | less
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

avless () {
  av -L 10000 -w 10000 -cx $@ | less -S
}

waid () {
  ps ux --sort s | less -S
}

# Should make my own css defaults for these guys
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

# Listing aliases
alias ll='ls -hl'
alias la='ls -hla'
alias wdid='ls -chlt | head'

# quick zsh mods
alias rzsh='source ~/.zshrc'
alias ezsh='vim ~/.zshrc'

# Ease access to betaratio stats -
alias brppf='beta_rat.py ppf'
alias brcdf='beta_rat.py cdf'


which colordiff > /dev/null && alias diff="colordiff"

bindkey '\e.' insert-last-word

# For when my clutsy ass forgets to add things to a git commit
forgitadd () {
  git reset --soft HEAD~1
  git add .
  git commit -c ORIG_HEAD
}


alias stderrxc='2>&1 > /dev/null | xc'


# From mr bates
c() { cd ~/code/$1; }
_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h


# For evil deeds...
hdoze () {
  if [[ -n $1 ]]
  then
    # Only parameter (optional) is height
    height=$1
  else
    # Default window height is...
    height=1380
  fi
  rdesktop -u csmall -d FHCRC phs-terminal.fhcrc.org -K -T "For evil deeds..." -g 1450x$height
}


alias ack='ack-grep'

# Specifically relevant to hypermut output - make columns easier to read
alias hmin='csvcut -C A_to_A,A_to_C,A_to_G,A_to_T,C_to_A,C_to_C,C_to_G,C_to_T,G_to_A,G_to_C,G_to_G,G_to_T,T_to_A,T_to_C,T_to_G,T_to_T'

# auto jump !
which autojump > /dev/null && . /usr/share/autojump/autojump.zsh && autoload -U compinit && compinit


[[ -s $HOME/.zshrc.local.after ]] && source $HOME/.zshrc.local.after


