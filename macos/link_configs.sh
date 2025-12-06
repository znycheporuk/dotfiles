#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
MACOS_DIR="${REPO_DIR}/macos"
TARGET_DIR="${HOME}/.config"

link_item() {
  local src="$1"
  local dest="$2"

  if [[ -L "$dest" ]]; then
    local current="$(readlink "$dest" || true)"
    if [[ "$current" == "$src" ]]; then
      echo "  ✅ $(basename "$dest")"
      return 0
    fi
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    mv "$dest" "${dest}.backup.$(date +%Y%m%d%H%M%S)"
    echo "  ⚠️  Backed up $(basename "$dest")"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "  🔗 $(basename "$dest")"
}

echo "🔗 Linking macOS configs to ~/.config"

# Link files from macos/* subdirectories to ~/.config/*
for dir in "$MACOS_DIR"/*; do
  [[ -d "$dir" ]] || continue

  config_name="$(basename "$dir")"

  # Skip non-config directories
  case "$config_name" in
    homebrew|zsh) continue ;;
  esac

  echo "📁 $config_name"

  # Link each file in the directory
  while IFS= read -r -d '' file; do
    rel_path="${file#$dir/}"
    dest_file="$TARGET_DIR/$config_name/$rel_path"
    link_item "$file" "$dest_file"
  done < <(find "$dir" -type f -print0)
done

# Link shared top-level configs
echo "📁 Shared configs"
for dir in "$REPO_DIR"/{nvim,ghostty,btop,yazi,zed}; do
  [[ -d "$dir" ]] || continue

  config_name="$(basename "$dir")"

  # Link each file in the directory
  while IFS= read -r -d '' file; do
    rel_path="${file#$dir/}"
    dest_file="$TARGET_DIR/$config_name/$rel_path"
    link_item "$file" "$dest_file"
  done < <(find "$dir" -type f -print0)
done

echo ""
echo "✅ Linking complete"
