eval "$(/opt/homebrew/bin/brew shellenv)"

sh ~/dotfiles/homebrew/install.sh
sh ~/dotfiles/macos/defaults.sh
# sh ~/dotfiles/macos/setup_shell.sh

initial_dir=$(pwd)
cd ~/dotfiles
stow .
cd "$initial_dir"

# Handle .zshrc linking with backup
if [[ -L ~/.zshrc ]]; then
    echo "✅ ~/.zshrc is already a symlink"
elif [[ -f ~/.zshrc ]]; then
    echo "📁 Backing up existing ~/.zshrc to ~/.zshrc.bak"
    mv ~/.zshrc ~/.zshrc.bak
    ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
    echo "🔗 Created symlink ~/.zshrc -> ~/dotfiles/zsh/.zshrc"
else
    ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
    echo "🔗 Created symlink ~/.zshrc -> ~/dotfiles/zsh/.zshrc"
fi
