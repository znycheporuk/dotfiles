#!/bin/bash

# Zsh Setup Script
# This script sets up Zsh shell with starship, autosuggestions, and syntax highlighting

set -e

echo "🚀 Setting up Zsh shell..."

# Check if Zsh is installed
if ! command -v zsh &> /dev/null; then
    echo "❌ Zsh is not installed. Installing via Homebrew..."
    if command -v brew &> /dev/null; then
        brew install zsh
    else
        echo "❌ Homebrew not found. Please install Zsh manually:"
        echo "   Visit: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH"
        exit 1
    fi
fi

# Get the path to Zsh
ZSH_PATH=$(which zsh)
echo "✅ Zsh found at: $ZSH_PATH"

# Check if Zsh is already in /etc/shells
if ! grep -q "$ZSH_PATH" /etc/shells; then
    echo "🔧 Adding Zsh to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells
else
    echo "✅ Zsh is already in /etc/shells"
fi

# Check current shell
CURRENT_SHELL=$(echo $SHELL)
if [ "$CURRENT_SHELL" = "$ZSH_PATH" ]; then
    echo "✅ Zsh is already your default shell"
else
    echo "🔄 Changing default shell to Zsh..."
    echo "You may be prompted for your password..."
    chsh -s "$ZSH_PATH"
    echo "✅ Default shell changed to Zsh"
    echo "ℹ️  You may need to restart your terminal or log out/in for changes to take effect"
fi

# Install required dependencies
echo "🔧 Installing dependencies..."

# Install starship
if ! command -v starship &> /dev/null; then
    echo "📦 Installing Starship prompt..."
    brew install starship
else
    echo "✅ Starship is already installed"
fi

# Install zsh-autosuggestions
if [[ ! -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    echo "📦 Installing zsh-autosuggestions..."
    brew install zsh-autosuggestions
else
    echo "✅ zsh-autosuggestions is already installed"
fi

# Install zsh-syntax-highlighting
if [[ ! -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    echo "📦 Installing zsh-syntax-highlighting..."
    brew install zsh-syntax-highlighting
else
    echo "✅ zsh-syntax-highlighting is already installed"
fi

# Install FNM if not present
if ! command -v fnm &> /dev/null; then
    echo "📦 Installing FNM (Fast Node Manager)..."
    brew install fnm
else
    echo "✅ FNM is already installed"
fi

# Optional modern CLI tools
echo "🔧 Installing optional modern CLI tools..."

# Install bat (better cat)
if ! command -v bat &> /dev/null; then
    echo "📦 Installing bat (better cat)..."
    brew install bat
else
    echo "✅ bat is already installed"
fi

echo ""
echo "🎉 Zsh setup complete!"
echo ""
echo "📋 Next steps:"
echo "   1. Restart your terminal or run: exec zsh"
echo "   2. Your Zsh configuration will be loaded from ~/.zshrc"
echo "   3. The configuration includes:"
echo "      • Starship prompt with dark/light mode detection"
echo "      • Long deduplicated history (100k entries)"
echo "      • Autosuggestions based on history"
echo "      • Syntax highlighting"
echo "      • FNM integration for Node.js"
echo ""
echo "💡 Features:"
echo "   - History deduplication (only sequential duplicates removed)"
echo "   - Shared history between sessions"
echo "   - Automatic Node.js version switching with FNM"
echo "   - Dark/light theme switching for Starship and bat"
echo ""
echo "🔧 If you need to revert to your previous shell:"
echo "   chsh -s $(grep ^$(whoami): /etc/passwd | cut -d: -f7)"
