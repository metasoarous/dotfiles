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

csvhead () {
  head $@ | csvlook
}

csvtail () {
  htail $@ | csvlook
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


alias ack='ack-grep'

# Specifically relevant to hypermut output - make columns easier to read
alias hmin='csvcut -C A_to_A,A_to_C,A_to_G,A_to_T,C_to_A,C_to_C,C_to_G,C_to_T,G_to_A,G_to_C,G_to_G,G_to_T,T_to_A,T_to_C,T_to_G,T_to_T'


# Cluster stuffs!!!!!!
# ====================

myjobs () {
  squeue -u $(whoami) -o "%.7i %.9P %.20j %.8u %.2t %.10M %.10M6D %R" $@
}

function mailme(){
    echo $(date): your command on $SLURMD_NODENAME exited with status $? | mail -s 'hyrax job done!' csmall@fhcrc.org
}
# Example:
# grabfullnode
# > long_running_process.sh; mailme; exit

# Also note: nodetop gizmod33 (for example), scancel, 
# scontrol show job $SLURM_JOB_ID


[[ -s $HOME/.zshrc.local.after ]] && source $HOME/.zshrc.local.after

