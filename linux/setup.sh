#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
PACKAGES_INSTALL="${REPO_DIR}/linux/packages/install.sh"
LINK_SCRIPT="${REPO_DIR}/linux/link_configs.sh"
LINUX_ZSH="${REPO_DIR}/linux/zsh/.zshrc"

echo "🔧 Linux dotfiles setup"

[[ ! -d "$REPO_DIR" ]] && { echo "❌ $REPO_DIR not found"; exit 1; }

# Install packages (optional)
if [[ -f "$PACKAGES_INSTALL" ]]; then
  read -p "Install/update packages? [y/N] " -n 1 -r
  echo
  [[ $REPLY =~ ^[Yy]$ ]] && sh "$PACKAGES_INSTALL" || echo "⏭️  Skipped packages"
fi

# Link configs
if [[ -f "$LINK_SCRIPT" ]]; then
  sh "$LINK_SCRIPT"
else
  echo "⚠️  link_configs.sh not found"
fi

# Link zsh config
if [[ -f "$LINUX_ZSH" ]]; then
  if [[ -L "$HOME/.zshrc" ]]; then
    current="$(readlink "$HOME/.zshrc" || true)"
    [[ "$current" == "$LINUX_ZSH" ]] && echo "✅ .zshrc already linked" || {
      rm "$HOME/.zshrc"
      ln -s "$LINUX_ZSH" "$HOME/.zshrc"
      echo "🔗 Updated .zshrc"
    }
  elif [[ -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    ln -s "$LINUX_ZSH" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc (backed up existing)"
  else
    ln -s "$LINUX_ZSH" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc"
  fi
fi

echo "✅ Linux setup complete"
