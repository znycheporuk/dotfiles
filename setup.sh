eval "$(/opt/homebrew/bin/brew shellenv)"

sh ~/dotfiles/homebrew/install.sh
sh ~/dotfiles/macos/defaults.sh
sh ~/dotfiles/macos/setup_shell.sh
sh ~/dotfiles/stow.sh

echo "Changing the default terminal to WezTerm..."
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
  '{ LSHandlerRoleAll = "com.github.wez.wezterm"; LSHandlerURLScheme = "file"; }'