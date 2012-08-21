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
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/X11R6/bin:/usr/games:/usr/lib/mit/bin
[[ -s $HOME/.zshrc.local ]] && source $HOME/.zshrc.local
# Load oh my zsh
source $ZSH/oh-my-zsh.sh


# I've decided maybe autocorrection IS maybe more trouble than worth...
unsetopt correct_all


# Ocaml dev settings
OCAMLRUNPARAM=b


# Load rvm if present
[[ -s "/home/$USER/.rvm/scripts/rvm" ]] && source "/home/$USER/.rvm/scripts/rvm" 


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

# Listing aliases
alias ll='ls -hl'
alias la='ls -hla'
alias wdid='ls -chlt | head'

# quick zsh mods
alias rzsh='source ~/.zshrc'
alias ezsh='vim ~/.zshrc'


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


