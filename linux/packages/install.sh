#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_LIST="${SCRIPT_DIR}/pacman.txt"
PARU_LIST="${SCRIPT_DIR}/paru.txt"

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║          Installing packages for Linux (Arch/CachyOS)          ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Check if running on Arch-based system
if ! command -v pacman &> /dev/null; then
    echo "❌ Error: pacman not found. This script is for Arch-based systems only."
    exit 1
fi

# Function to read package list (ignoring comments and empty lines)
read_packages() {
    local file="$1"
    grep -v '^#' "$file" | grep -v '^$' | tr '\n' ' '
}

# Install pacman packages
if [[ -f "$PACMAN_LIST" ]]; then
    echo "📦 Installing official repository packages..."
    echo ""
    
    packages=$(read_packages "$PACMAN_LIST")
    
    # Check which packages are not installed
    to_install=""
    for pkg in $packages; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            to_install="$to_install $pkg"
        fi
    done
    
    if [[ -n "$to_install" ]]; then
        echo "Installing: $to_install"
        sudo pacman -S --needed --noconfirm $to_install
        echo ""
        echo "✅ Official packages installed"
    else
        echo "✅ All official packages already installed"
    fi
else
    echo "⚠️  Warning: $PACMAN_LIST not found"
fi

echo ""

# Check if paru is installed
if ! command -v paru &> /dev/null; then
    echo "📦 Installing paru (AUR helper)..."
    
    # Check if yay is available as alternative
    if command -v yay &> /dev/null; then
        echo "Using yay to install paru..."
        yay -S --needed --noconfirm paru
    else
        echo "Installing paru from source..."
        temp_dir=$(mktemp -d)
        cd "$temp_dir"
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si --noconfirm
        cd
        rm -rf "$temp_dir"
    fi
    
    echo "✅ paru installed"
fi

echo ""

# Install AUR packages
if [[ -f "$PARU_LIST" ]]; then
    echo "📦 Installing AUR packages..."
    echo ""
    
    packages=$(read_packages "$PARU_LIST")
    
    # Check which packages are not installed
    to_install=""
    for pkg in $packages; do
        if ! pacman -Qi "$pkg" &> /dev/null; then
            to_install="$to_install $pkg"
        fi
    done
    
    if [[ -n "$to_install" ]]; then
        echo "Installing from AUR: $to_install"
        paru -S --needed --noconfirm $to_install
        echo ""
        echo "✅ AUR packages installed"
    else
        echo "✅ All AUR packages already installed"
    fi
else
    echo "⚠️  Warning: $PARU_LIST not found"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                    Installation Complete!                      ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "📝 Installed packages from:"
echo "   - Official repos: $PACMAN_LIST"
echo "   - AUR: $PARU_LIST"
echo ""
echo "🔧 Next steps:"
echo "   1. Run 'sh ~/dotfiles/setup.sh' to link configs"
echo "   2. Log out and select 'niri' from your display manager"
echo "   3. Enjoy your setup!"
