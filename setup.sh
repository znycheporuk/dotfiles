#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${HOME}/dotfiles"

case "$(uname -s)" in
  Darwin)
    [[ -f "${REPO_DIR}/macos/setup.sh" ]] || { echo "❌ macos/setup.sh not found"; exit 1; }
    sh "${REPO_DIR}/macos/setup.sh"
    ;;
  Linux)
    [[ -f "${REPO_DIR}/linux/setup.sh" ]] || { echo "❌ linux/setup.sh not found"; exit 1; }
    sh "${REPO_DIR}/linux/setup.sh"
    ;;
  *)
    echo "Unsupported OS: $(uname -s)"
    exit 1
    ;;
esac
