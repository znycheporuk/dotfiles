# Dotfiles

Cross-platform dotfiles for macOS and Linux (Linux support coming soon).

## Structure

```
~/dotfiles/
├── setup.sh              # Main installer (detects OS and runs platform script)
├── macos/                # macOS-specific configs
│   ├── setup.sh          # macOS installer
│   ├── link_configs.sh   # Symlink helper (links files, not directories)
│   ├── defaults.sh       # System defaults (Finder, Dock, etc.)
│   ├── homebrew/         # Brewfile and installer
│   ├── zsh/              # macOS zsh config
│   ├── aerospace/        # Window manager
│   ├── karabiner/        # Keyboard remapping
│   ├── sketchybar/       # Menu bar
│   ├── starship/         # Prompt themes
│   └── bat/              # Syntax highlighting
├── linux/                # Linux-specific configs (not implemented yet)
│   └── zsh/              # Linux zsh config
├── nvim/                 # Neovim config (shared)
├── ghostty/              # Terminal config (shared)
├── btop/                 # System monitor (shared)
├── yazi/                 # File manager (shared)
└── zed/                  # Editor config (shared, only settings.json tracked)
```

## Installation

### macOS

Clone to `~/dotfiles` and run:

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh setup.sh
```

This will:
1. Install Homebrew packages from `macos/homebrew/Brewfile`
2. Apply macOS system defaults
3. Symlink config files to `~/.config/`
4. Link `~/.zshrc` to `macos/zsh/.zshrc`

### Linux

Not implemented yet.

## How It Works

### Platform Detection

`setup.sh` detects your OS and delegates to the appropriate platform script:
- macOS → `macos/setup.sh`
- Linux → `linux/setup.sh` (placeholder)

### Config Linking

`macos/link_configs.sh` creates symlinks for **individual files** (not directories):

**From `macos/*/`:**
- `macos/aerospace/aerospace.toml` → `~/.config/aerospace/aerospace.toml`
- `macos/starship/dark.toml` → `~/.config/starship/dark.toml`
- `macos/bat/config` → `~/.config/bat/config`
- etc.

**From top-level shared configs:**
- `nvim/init.lua` → `~/.config/nvim/init.lua`
- `ghostty/config` → `~/.config/ghostty/config`
- `zed/settings.json` → `~/.config/zed/settings.json`
- etc.

**Behavior:**
- Backs up existing files with `.backup.TIMESTAMP` suffix
- Skips `.gitignore` files
- Preserves directory structure
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
4. Files will be symlinked to `~/.config/myapp/`

### Add a macOS-Only Config

1. Create directory: `mkdir ~/dotfiles/macos/myapp`
2. Add config files inside
3. Run `sh ~/dotfiles/macos/link_configs.sh`
4. Files will be symlinked to `~/.config/myapp/`

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

### Prevent Files from Being Tracked

Add a `.gitignore` in the config directory. For example, `zed/.gitignore` prevents Zed's auto-generated files from being tracked:

```gitignore
*
!settings.json
!.gitignore
```

This keeps only `settings.json` in version control while allowing Zed to create other files in `~/.config/zed/`.

## Files Reference

| File | Purpose |
|------|---------|
| `setup.sh` | OS detection and dispatcher |
| `macos/setup.sh` | Orchestrates macOS setup steps |
| `macos/link_configs.sh` | Creates symlinks to ~/.config (file-level) |
| `macos/defaults.sh` | System preferences (Dock, Finder, etc) |
| `macos/homebrew/Brewfile` | Package list for Homebrew |
| `macos/homebrew/install.sh` | Homebrew bootstrap and bundle installer |
| `macos/zsh/.zshrc` | Shell configuration for macOS |

## Notes

- Existing files are backed up before symlinking (`.backup.TIMESTAMP`)
- Scripts are idempotent - safe to run multiple times
- No external dependencies except Homebrew (installed automatically on macOS)
- File-level linking (not directory-level) - allows apps to create their own files in `~/.config/`
- Only explicitly tracked files in the repo are symlinked