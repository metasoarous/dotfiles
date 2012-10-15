# Chris Small Dot Files

These are config files for setting up a system the way I like it. It is
based on the Ryan Bates Dot Files repository.

## Opinions/Features

* zsh and oh-my-zsh
* vim with janus
* tmux FTW
* Linux (but will probably mostly work with OS X just fine)

## Installation

Run the following commands in your terminal. It will prompt you before it does anything destructive. Check out the [Rakefile](https://github.com/metasoarous/dotfiles/blob/custom-bash-zsh/Rakefile) to see exactly what it does.

```terminal
git clone git://github.com/metasoarous/dotfiles ~/.dotfiles
cd ~/.dotfiles
# If you want to backup your existing config files before getting in too
# deep...
rake backup
# then jump in
rake install
```

After installing, open a new terminal window to see the effects.

In contrast to the rbates version, this rakefile does not copy the zshrc
file to `.zshrc`. As such, you can fork this repo and make your own
changes which will be maintained across systems. If you need
customizations on a system by system basis though, you can create a
`.zshrc.local` file.


## Features - rabtes plugin

Many of the following features are added through the "rbates" Oh My ZSH plugin. This plugin is no longer included by default, but will have to be added to your `.zshrc`.

Ryan (and I) normally place all coding projects in ~/code. As a convenience, this plugin makes it possible to access (and tab complete) this directory with the "c" command.

```terminal
c railsca<tab>
```

There is also an "h" command which behaves similar, but acts on the home path.

```terminal
h doc<tab>
```

Tab completion is also added to rake and cap commands:

```
rake db:mi<tab>
cap de<tab>
```

To speed things up, the results are cached in local .rake_tasks~ and .cap_tasks~. It is smart enough to expire the cache automatically in most cases, but you can simply remove the files to flush the cache.

If you're using git, you'll notice the current branch name shows up in the prompt while in a git repository.

There are several features enabled in Ruby's irb including history and completion. Many convenience methods are added as well such as "ri" which can be used to get inline documentation in IRB. See irbrc file for details.


## Uninstall

To remove the dotfile configs, just remove all of the links using `unlink`. Then you can 

```
unlink ~/.bin
unlink ~/.gitignore
unlink ~/.gemrc
unlink ~/.gvimrc
unlink ~/.irbrc
unlink ~/.vim
unlink ~/.vimrc
unlink ~/.zshrc
rm ~/.gitconfig
rm -rf ~/.oh-my-zsh
# change back to Bash
chsh -s /bin/bash
# If your really feeling so inclined - not necessary
rm -rf ~/.dotfiles
```

You can then look in ~/.dotfiles/backups/ for any previous settings
which you would like to restore, open up a new terminal session, and see
things the way they used to be.


## Future

I have vague plans of making it so that this repository only contains
the mechanics for managing dotfiles, but allowing for users to specify
their own dotfiles repository as a submodule, making it possible for
this code base to be used by folks with wildly different setups without
having to fork the mechanical stuff. Hopefully, this will lead to other
folks using the mechanical stuff, improving on the code base, and making
it really easy for everyone to have their own way with this.

Other tidbits -

Automaticall chmod +x bin/*
