#!/bin/sh

mkdir -p "$HOME/Library/Application Support/nushell"
mkdir -p "$HOME/.config/aerospace"
mkdir -p "$HOME/.config/bat"
mkdir -p "$HOME/.config/nvim"
mkdir -p "$HOME/.config/starship"
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.config/wezterm"
mkdir -p "$HOME/.config/zed"

stow -d "$HOME/dotfiles" -t "$HOME/Library/Application Support/nushell" nushell
stow -d "$HOME/dotfiles" -t "$HOME/.config/aerospace" aerospace
stow -d "$HOME/dotfiles" -t "$HOME/.config/bat" bat
stow -d "$HOME/dotfiles" -t "$HOME/.config/nvim" nvim
stow -d "$HOME/dotfiles" -t "$HOME/.config/starship" starship
stow -d "$HOME/dotfiles" -t "$HOME/.config/tmux" tmux
stow -d "$HOME/dotfiles" -t "$HOME/.config/wezterm" wezterm
stow -d "$HOME/dotfiles" -t "$HOME/.config/zed" zed
