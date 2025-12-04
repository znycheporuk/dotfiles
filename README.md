# Dotfiles

Personal configuration files for macOS and Linux development environments.

## Structure

```
dotfiles/
├── setup.sh              # Main entry point - detects OS and runs platform setup
├── macos/                # macOS-specific configurations
│   ├── setup.sh          # macOS setup script
│   ├── link_configs.sh   # Symlinks configs to ~/.config
│   ├── defaults.sh       # macOS system preferences
│   ├── homebrew/         # Homebrew packages
│   ├── zsh/              # macOS zsh config
│   ├── aerospace/        # Window manager
│   ├── karabiner/        # Keyboard remapping
│   ├── sketchybar/       # Menu bar
│   ├── starship/         # Prompt themes
│   └── bat/              # cat replacement
├── linux/                # Linux-specific configurations
│   └── zsh/              # Linux zsh config
├── nvim/                 # Neovim config (shared)
├── ghostty/              # Terminal config (shared)
├── btop/                 # System monitor (shared)
├── yazi/                 # File manager (shared)
└── zed/                  # Editor config (shared, only settings.json linked)
```

## Installation

### macOS

```bash
git clone https://github.com/znycheporuk/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh
```

This will:
1. Install Homebrew packages from `macos/homebrew/Brewfile`
2. Apply macOS system preferences from `macos/defaults.sh`
3. Symlink shared configs (`nvim`, `ghostty`, `btop`, `yazi`) to `~/.config/`
4. Symlink `zed/settings.json` to `~/.config/zed/settings.json`
5. Symlink `~/.zshrc` to `macos/zsh/.zshrc`

### Linux

Not yet implemented. The structure is ready - add `linux/setup.sh` when needed.

## How It Works

### Platform Detection

`setup.sh` detects your OS and delegates to the appropriate platform script:
- macOS → `macos/setup.sh`
- Linux → `linux/setup.sh` (placeholder)

### Config Linking

`macos/link_configs.sh` creates symlinks from `~/dotfiles/` to `~/.config/`:
- Ignores: `macos`, `linux`, `.git`, `setup.sh`, `README.md`, `zed`
- Special case: `zed` - only links `settings.json`, not the entire directory
- Backs up existing files with `.backup.TIMESTAMP` suffix
- Idempotent - safe to run multiple times

### Platform-Specific vs Shared

**Platform-specific** (under `macos/` or `linux/`):
- Shell configs (zsh)
- OS-specific tools (karabiner, aerospace, homebrew)
- System preferences
- Window managers, menu bars

**Shared** (top-level):
- Editor configs (nvim, zed)
- Terminal (ghostty)
- CLI tools (btop, yazi)

## Modifying

### Add a New Shared Config

1. Create directory: `mkdir ~/dotfiles/myapp`
2. Add config files inside
3. Run `sh ~/dotfiles/macos/link_configs.sh`
4. Result: `~/.config/myapp` → `~/dotfiles/myapp`

### Add a macOS-Only Config

1. Create directory: `mkdir ~/dotfiles/macos/myapp`
2. Add config files inside
3. Optionally add setup logic to `macos/setup.sh`

### Modify Homebrew Packages

Edit `macos/homebrew/Brewfile`, then run:
```bash
brew bundle --file=~/dotfiles/macos/homebrew/Brewfile
```

### Modify macOS Preferences

Edit `macos/defaults.sh`, then run:
```bash
sh ~/dotfiles/macos/defaults.sh
```

### Change Ignore List

Edit the `IGNORE` array in `macos/link_configs.sh` to control which top-level directories are symlinked.

## Files Reference

| File | Purpose |
|------|---------|
| `setup.sh` | OS detection and dispatcher |
| `macos/setup.sh` | Orchestrates macOS setup steps |
| `macos/link_configs.sh` | Creates symlinks to ~/.config |
| `macos/defaults.sh` | System preferences (Dock, Finder, etc) |
| `macos/homebrew/Brewfile` | Package list for Homebrew |
| `macos/homebrew/install.sh` | Homebrew bootstrap and bundle installer |
| `macos/zsh/.zshrc` | Shell configuration for macOS |

## Notes

- Existing files are backed up before symlinking (`.bak` or `.backup.TIMESTAMP`)
- Scripts are idempotent - safe to run multiple times
- No external dependencies except Homebrew (installed automatically on macOS)
- GNU Stow is not used - simple `ln -s` based linking