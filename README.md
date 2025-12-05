# Dotfiles

Cross-platform configuration files for macOS and Linux development environments.

## Quick Start

```bash
git clone https://github.com/znycheporuk/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh
```

The setup script automatically detects your OS and:
- **macOS**: Installs Homebrew packages, applies system preferences, links configs
- **Linux**: Optionally installs packages via pacman/paru, links configs

## Structure

```
dotfiles/
├── setup.sh           # OS detection & dispatcher
├── macos/             # macOS-specific
│   ├── setup.sh       # Package install, system prefs, config linking
│   ├── homebrew/      # Brewfile for packages
│   ├── aerospace/     # Window manager
│   ├── karabiner/     # Keyboard remapping
│   └── ...
├── linux/             # Linux-specific
│   ├── setup.sh       # Package install, config linking
│   ├── packages/      # pacman.txt + paru.txt (like Brewfile)
│   ├── niri/          # Wayland compositor
│   ├── noctalia/      # Shell/bar config
│   └── ...
├── nvim/              # Shared editor config
├── yazi/              # Shared file manager
├── btop/              # Shared system monitor
└── zed/               # Shared editor settings
```

## Platform-Specific Features

### macOS
- **Window Manager**: AeroSpace (tiling, named workspaces)
- **Package Manager**: Homebrew (`macos/homebrew/Brewfile`)
- **System Preferences**: Automated via `macos/defaults.sh`
- **Tools**: Karabiner, SketchyBar, Starship

### Linux (Arch/CachyOS)
- **Window Manager**: Niri (scrollable-tiling compositor)
- **Package Manager**: pacman + paru (`linux/packages/*.txt`)
- **Shell/Bar**: Quickshell + Noctalia
- **Tools**: Vicinae, all necessary XDG portals

## Window Manager Keybindings

Both systems use consistent vim-style navigation:

| Action | macOS (AeroSpace) | Linux (Niri) |
|--------|-------------------|--------------|
| Focus window | `Alt+H/J/K/L` | `Mod+H/J/K/L` |
| Move window | `Alt+Ctrl+H/J/K/L` | `Mod+Ctrl+H/J/K/L` |
| Switch workspace | `Alt+[Letter]` | `Mod+[Letter]` |
| Launch apps | `Alt+Shift+[Key]` | `Super+Shift+[Key]` |

**Named Workspaces**: M (Main), B (Browser), G (Ghostty), S (Steam/Slack), T (Telegram), Z (Zed)

## Package Management

### macOS
```bash
# Edit packages
nvim ~/dotfiles/macos/homebrew/Brewfile

# Install/update
brew bundle --file=~/dotfiles/macos/homebrew/Brewfile
```

### Linux
```bash
# Edit packages
nvim ~/dotfiles/linux/packages/pacman.txt  # Official repos
nvim ~/dotfiles/linux/packages/paru.txt    # AUR

# Install/update
sh ~/dotfiles/linux/packages/install.sh
```

## Adding New Configs

**Shared config** (works on both platforms):
```bash
mkdir ~/dotfiles/myapp
# Add config files
sh ~/dotfiles/setup.sh  # Re-run setup to link
```

**Platform-specific**:
```bash
mkdir ~/dotfiles/macos/myapp   # or linux/myapp
# Add config files
sh ~/dotfiles/macos/setup.sh   # or linux/setup.sh
```

## Config Linking

Configs are symlinked to `~/.config/`:
- **Shared**: `nvim`, `yazi`, `btop`, `zed` (settings.json only)
- **macOS**: `aerospace`, `karabiner`, `sketchybar`, `ghostty`, `starship`, `bat`
- **Linux**: `niri`, `ghostty`, `noctalia`, `vicinae`

Existing files are backed up with `.backup.TIMESTAMP` suffix.

## Key Apps & Tools

| Category | macOS | Linux | Shared |
|----------|-------|-------|--------|
| Editor | - | - | Neovim, Zed |
| Terminal | - | - | Ghostty |
| File Manager | - | - | Yazi |
| System Monitor | - | - | btop |
| Window Manager | AeroSpace | Niri | - |
| Shell | zsh | zsh | - |
| Bar/Status | SketchyBar | Noctalia | - |

## Notes

- All scripts are idempotent (safe to run multiple times)
- Configs auto-reload where supported (e.g., Niri live-reloads on save)
- Use `niri validate` to check Niri config syntax
- macOS system preferences require logout/restart to fully apply
