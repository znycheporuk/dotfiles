#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
PACKAGES_INSTALL="${REPO_DIR}/linux/packages/install.sh"
LINK_SCRIPT="${REPO_DIR}/linux/link_configs.sh"
LINUX_ZSHRC="${REPO_DIR}/linux/zsh/.zshrc"

echo "🔧 Setting up Linux dotfiles"

[[ ! -d "$REPO_DIR" ]] && { echo "❌ $REPO_DIR not found"; exit 1; }

# Install packages (optional, will be skipped if packages already installed)
if [[ -f "$PACKAGES_INSTALL" ]]; then
  echo ""
  read -p "Install/update packages? [y/N] " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sh "$PACKAGES_INSTALL"
  else
    echo "⏭️  Skipping package installation"
  fi
else
  echo "⚠️  Package installer not found at $PACKAGES_INSTALL"
fi

echo ""

# Link configs to ~/.config
if [[ -f "$LINK_SCRIPT" ]]; then
  sh "$LINK_SCRIPT"
else
  echo "⚠️  $LINK_SCRIPT not found"
fi

# Link .zshrc
if [[ -f "$LINUX_ZSHRC" ]]; then
  if [[ -L "$HOME/.zshrc" ]]; then
    current="$(readlink "$HOME/.zshrc" || true)"
    [[ "$current" == "$LINUX_ZSHRC" ]] && { echo "✅ ~/.zshrc already linked"; } || {
      rm "$HOME/.zshrc"
      ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
      echo "🔗 Updated ~/.zshrc"
    }
  elif [[ -f "$HOME/.zshrc" ]]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup.$(date +%Y%m%d%H%M%S)"
    ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked ~/.zshrc (backed up old one)"
  else
    ln -s "$LINUX_ZSHRC" "$HOME/.zshrc"
    echo "🔗 Linked ~/.zshrc"
  fi
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                 Linux Setup Complete!                          ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "✅ Configs linked to ~/.config"
echo "✅ Shell configured (~/.zshrc)"
echo ""
echo "📝 Next steps:"
echo "   - Restart your shell or run: source ~/.zshrc"
echo "   - If using niri, log out and select 'niri' from display manager"
echo "   - Review configs in ~/dotfiles/linux/"
