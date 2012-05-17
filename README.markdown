# Gerardo Curiel Dotfiles

These are my dotfiles, a set of config files to set up a *NIX system
with my personal preferences.

## Installation

    git clone git://github.com/gerardo/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    ./install.sh

If you use the `Curiel` zsh theme from my oh-my-zsh fork(that's the current
setup) you will need to install virtualenv and virtualenvwrapper.

On Debian:

    aptitude install python-virtualenv virtualenvwrapper

Or via `pip` on Mac OSX and others:

    pip install virtualenv virtualenvwrapper

## Environment

I use this setup on Linux and Mac OSX systems. I use ZSH as my preferred shell,
but there's some older bash files around too. Really, you should switch to
ZSH, just change your shell with the following command:

` chsh -s /bin/zsh `

and you're all set!

The environment is in the lines of Python, Django, homebrew, Vim, Git,
Mercurial, OSX/Linux.

### Sensible OS X defaults

When setting up a new Mac, you may want to set some sensible OS X defaults:

``bash
./.osx
``

## Features

More information to come.

## Feedback

Suggestions and improvements [welcome](https://github.com/gerardo/dotfiles/issues)!

## Thanks to…

* [Mathias Bynens](http://mathiasbynens.be/) for sharing his osx settings from his
[dotfiles](https://github.com/mathiasbynens/dotfiles) repository.
