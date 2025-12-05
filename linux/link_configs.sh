#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-${HOME}/dotfiles}"
TARGET_DIR="${TARGET_DIR:-${HOME}/.config}"

# Shared configs (top-level) + Linux-specific configs
IGNORE=("macos" "linux" ".git" ".gitignore" "setup.sh" "README.md" "zed")

is_ignored() {
  local name="$1"
  for ig in "${IGNORE[@]}"; do
    [[ "$ig" == "$name" ]] && return 0
  done
  return 1
}

link_file() {
  local src="$1"
  local dest="$2"

  if [[ -L "$dest" ]]; then
    local current="$(readlink "$dest" || true)"
    if [[ "$current" == "$src" ]]; then
      echo "✅ $dest"
      return 0
    fi
    rm "$dest"
  elif [[ -e "$dest" ]]; then
    mv "$dest" "${dest}.backup.$(date +%Y%m%d%H%M%S)"
  fi

  ln -s "$src" "$dest"
  echo "🔗 $dest -> $src"
}

mkdir -p "$TARGET_DIR"

# Link shared top-level directories
for entry in "$REPO_DIR"/*; do
  [[ -d "$entry" ]] || continue

  name="$(basename "$entry")"
  [[ "$name" == .* ]] && continue
  is_ignored "$name" && continue

  link_file "$entry" "$TARGET_DIR/$name"
done

# Link Linux-specific configs from linux/
for entry in "$REPO_DIR/linux"/*; do
  [[ -d "$entry" ]] || continue
  
  name="$(basename "$entry")"
  # Skip zsh directory (handled separately)
  [[ "$name" == "zsh" ]] && continue
  
  link_file "$entry" "$TARGET_DIR/$name"
done

# Special case: link only settings.json from zed
if [[ -f "$REPO_DIR/zed/settings.json" ]]; then
  mkdir -p "$TARGET_DIR/zed"
  link_file "$REPO_DIR/zed/settings.json" "$TARGET_DIR/zed/settings.json"
fi

echo "✅ Linking complete"
