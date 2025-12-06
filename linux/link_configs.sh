#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"
LINUX_DIR="${REPO_DIR}/linux"
TARGET_DIR="${HOME}/.config"

link_file() {
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

echo "🔗 Linking Linux configs to ~/.config"

# Link files from linux/* subdirectories to ~/.config/*
for dir in "$LINUX_DIR"/*; do
  [[ -d "$dir" ]] || continue

  config_name="$(basename "$dir")"

  # Skip non-config directories
  case "$config_name" in
    packages|zsh) continue ;;
  esac

  echo "📁 $config_name"

  # Link each file in the directory
  while IFS= read -r -d '' file; do
    rel_path="${file#$dir/}"
    dest_file="$TARGET_DIR/$config_name/$rel_path"
    link_file "$file" "$dest_file"
  done < <(find "$dir" -type f -print0)
done

# Link shared top-level configs
echo "📁 Shared configs"
for dir in "$REPO_DIR"/{nvim,ghostty,btop,yazi,zed}; do
  [[ -d "$dir" ]] || continue

  config_name="$(basename "$dir")"

  # Link each file individually
  while IFS= read -r -d '' file; do
    rel_path="${file#$dir/}"
    dest_file="$TARGET_DIR/$config_name/$rel_path"
    link_file "$file" "$dest_file"
  done < <(find "$dir" -type f -not -name '.gitignore' -print0)
done

echo ""
echo "✅ Linking complete"
