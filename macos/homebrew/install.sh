#!/bin/sh

eval "$(/opt/homebrew/bin/brew shellenv)"

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.github.com/rcmdnk/homebrew-file/install/install.sh)"
fi

brew bundle --file=~/dotfiles/macos/homebrew/Brewfile
