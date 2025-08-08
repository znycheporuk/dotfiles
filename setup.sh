eval "$(/opt/homebrew/bin/brew shellenv)"

sh ~/dotfiles/homebrew/install.sh
sh ~/dotfiles/macos/defaults.sh
# sh ~/dotfiles/macos/setup_shell.sh

initial_dir=$(pwd)
cd ~/dotfiles
stow .
ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
cd "$initial_dir"
