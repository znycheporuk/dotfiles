#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
LINUX_ZSHRC="${REPO_DIR}/linux/zsh/.zshrc"

echo "🔧 Linux dotfiles setup"

[[ ! -d "$REPO_DIR" ]] && { echo "❌ $REPO_DIR not found"; exit 1; }

# Install packages (optional)
if [[ -f "${REPO_DIR}/linux/packages/install.sh" ]]; then
  read -p "Install/update packages? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "📦 Installing packages"
    sh "${REPO_DIR}/linux/packages/install.sh"
  fi
fi

# Link configs
if [[ -f "${REPO_DIR}/linux/link_configs.sh" ]]; then
  bash "${REPO_DIR}/linux/link_configs.sh"
else
  echo "⚠️ link_configs.sh not found"
fi

# Link zsh config
if [[ -f "$LINUX_ZSHRC" ]]; then
  if [[ -L "$HOME/.zshrc" ]]; then
    current="$(readlink "$HOME/.zshrc" || true)"
    [[ "$current" == "$LINUX_ZSHRC" ]] && echo "✅ .zshrc already linked" || {
      rm "$HOME/.zshrc"
      ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
      echo "🔗 Updated .zshrc"
    }
  elif [[ -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc (backed up existing)"
  else
    ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked .zshrc"
  fi
fi

echo "✅ Linux setup complete"
