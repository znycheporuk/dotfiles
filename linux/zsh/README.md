# Zsh Configuration

This directory contains a clean and focused Zsh configuration that provides exactly what you need: starship prompt, proper PATH variables, long deduplicated history, autosuggestions, and syntax highlighting.

## Features

- 🌈 **Starship prompt** with automatic dark/light theme switching
- 📚 **Smart history management** (100k entries, only sequential duplicates removed)
- 💡 **Autosuggestions** based on command history
- 🎨 **Syntax highlighting** for commands
- 🚀 **FNM integration** for Node.js version management
- ⚡ **Minimal and fast** - no heavy frameworks

## Installation

### 1. Run the Setup Script

```bash
# From the dotfiles directory
./zsh/setup_zsh.sh
```

This script will:
- Install Zsh if needed
- Add Zsh to `/etc/shells`
- Set Zsh as your default shell
- Install required dependencies (starship, zsh-autosuggestions, zsh-syntax-highlighting)
- Install optional tools (fnm, bat)

### 2. Apply Configuration with Stow

```bash
# From the dotfiles directory
stow zsh
```

### 3. Start Zsh

```bash
exec zsh
```

## Manual Installation

If you prefer to set up manually:

1. **Install dependencies:**
   ```bash
   brew install zsh starship zsh-autosuggestions zsh-syntax-highlighting fnm bat
   ```

2. **Add Zsh to allowed shells:**
   ```bash
   echo $(which zsh) | sudo tee -a /etc/shells
   ```

3. **Change default shell:**
   ```bash
   chsh -s $(which zsh)
   ```

4. **Symlink configuration:**
   ```bash
   stow zsh
   ```

## Configuration Details

### History Management

The configuration provides intelligent history management:

- **100,000 entries** - Long history that persists across sessions
- **Sequential duplicate removal** - If you run the same command multiple times in a row, only one is saved
- **Non-sequential duplicates preserved** - Commands separated by other commands are kept
- **Shared between sessions** - History is shared across all terminal sessions
- **Ignores commands starting with space** - Prefix with space for private commands

### Starship Prompt

Automatic theme switching based on macOS dark mode:
- **Dark mode**: Uses `~/.config/starship/dark.toml` + `Catppuccin Mocha` bat theme
- **Light mode**: Uses `~/.config/starship/light.toml` + `Catppuccin Latte` bat theme

### PATH Management

Properly configured PATH with:
- Homebrew binaries (`/opt/homebrew/bin`)
- OrbStack (`~/.orbstack/bin`)
- Local binaries (`/usr/local/bin`)
- FNM-managed Node.js versions (automatic)

### Plugins

Two essential plugins are included:
- **zsh-autosuggestions**: Shows suggestions based on your command history
- **zsh-syntax-highlighting**: Highlights commands as you type (green for valid, red for invalid)

## Key Features Explained

### History Deduplication

Unlike many Zsh configurations that remove ALL duplicates, this setup only removes **sequential duplicates**:

```bash
# This sequence:
ls
ls          # ← This duplicate won't be saved
ls          # ← This duplicate won't be saved
cd ..
ls          # ← This WILL be saved (not sequential)
```

### FNM Integration

Automatic Node.js version management:
- Auto-switches when entering directories with `.node-version` or `.nvmrc`
- Adds FNM-managed Node.js to PATH
- Works seamlessly with the existing setup

### Autosuggestions

- Type partial commands and see suggestions in gray text
- Press `→` (right arrow) to accept the suggestion
- Based on your actual command history

### Syntax Highlighting

- Commands turn green when valid
- Commands turn red when invalid/not found
- Helps catch typos before pressing Enter

## Dependencies

### Required
- **Zsh** 5.0+
- **Starship** - For the prompt

### Plugins (Auto-installed)
- **zsh-autosuggestions** - History-based command suggestions
- **zsh-syntax-highlighting** - Command syntax highlighting

### Optional but Recommended
- **FNM** - Fast Node Manager
- **bat** - Better cat with syntax highlighting

## Customization

### Adding Aliases

Add aliases directly to `.zshrc`:

```bash
echo 'alias ll="ls -la"' >> ~/.zshrc
```

### Modifying History Settings

Edit these variables in `.zshrc`:

```bash
HISTFILE=~/.zsh_history
HISTSIZE=100000          # In-memory history size
SAVEHIST=100000          # Saved history size
```

### Custom Functions

Add functions to `.zshrc`:

```bash
mkcd() {
    mkdir -p "$1" && cd "$1"
}
```

## Troubleshooting

### Autosuggestions Not Working

1. Ensure the plugin is installed:
   ```bash
   brew install zsh-autosuggestions
   ```

2. Check if the file exists:
   ```bash
   ls /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
   ```

### Syntax Highlighting Not Working

1. Ensure the plugin is installed:
   ```bash
   brew install zsh-syntax-highlighting
   ```

2. Check if the file exists:
   ```bash
   ls /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
   ```

### Starship Not Loading

1. Ensure Starship is installed:
   ```bash
   brew install starship
   ```

2. Check if the config files exist:
   ```bash
   ls ~/.config/starship/dark.toml ~/.config/starship/light.toml
   ```

### History Not Working

1. Check history file permissions:
   ```bash
   ls -la ~/.zsh_history
   ```

2. If corrupted, rebuild history:
   ```bash
   fc -R
   ```

## Performance

This configuration is designed to be fast and lightweight:
- No heavy frameworks (like Oh My Zsh)
- Minimal plugins (only 2)
- Efficient history management
- Fast startup time

## Comparison with Other Shells

| Feature | Zsh (this config) | Fish | Bash |
|---------|------------------|------|------|
| Starship integration | ✅ | ✅ | ✅ |
| Smart history | ✅ | ✅ | ❌ |
| Autosuggestions | ✅ | ✅ | ❌ |
| Syntax highlighting | ✅ | ✅ | ❌ |
| POSIX compatibility | ✅ | ❌ | ✅ |
| Setup complexity | Low | Medium | High |

## License

This configuration is part of the personal dotfiles repository and follows the same license terms.