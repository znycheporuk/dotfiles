#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
HOMEBREW_INSTALL="${REPO_DIR}/macos/homebrew/install.sh"
MACOS_DEFAULTS="${REPO_DIR}/macos/defaults.sh"
LINK_SCRIPT="${REPO_DIR}/macos/link_configs.sh"
MAC_ZSHRC="${REPO_DIR}/macos/zsh/.zshrc"

echo "🔧 Setting up macOS dotfiles"

[[ ! -d "$REPO_DIR" ]] && { echo "❌ $REPO_DIR not found"; exit 1; }

# Initialize Homebrew
if command -v brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || brew shellenv)" || true
fi

# Install Homebrew packages
if [[ -f "$HOMEBREW_INSTALL" ]]; then
  echo "📦 Installing Homebrew packages"
  sh "$HOMEBREW_INSTALL"
fi

# Apply macOS system defaults
if [[ -f "$MACOS_DEFAULTS" ]]; then
  echo "⚙️  Applying macOS defaults"
  sh "$MACOS_DEFAULTS"
fi

# Link configs to ~/.config
if [[ -f "$LINK_SCRIPT" ]]; then
  bash "$LINK_SCRIPT"
else
  echo "⚠️  link_configs.sh not found"
fi

# Link .zshrc
if [[ -f "$MAC_ZSHRC" ]]; then
  if [[ -L "$HOME/.zshrc" ]]; then
    current="$(readlink "$HOME/.zshrc" || true)"
    [[ "$current" == "$MAC_ZSHRC" ]] && echo "✅ .zshrc already linked" || {
      rm "$HOME/.zshrc"
      ln -s "$MAC_ZSHRC" "$HOME/.zshrc"
      echo "🔗 Updated .zshrc"
    }
  elif [[ -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    ln -s "$MAC_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc (backed up existing)"
  else
    ln -s "$MAC_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc"
  fi
fi

echo "✅ macOS setup complete"
