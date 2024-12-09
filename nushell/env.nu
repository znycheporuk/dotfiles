use std "path add"

path add /opt/homebrew/bin
path add /home/vaibhavdn/.fnm

# Starship
def is_dark_mode [] {
  let appearance = (osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode') | str trim
  $appearance == "true"
}

if (is_dark_mode) {
  $env.STARSHIP_CONFIG = "~/.config/starship/dark.toml"
  $env.BAT_THEME = "Catppuccin Mocha"
} else {
  $env.STARSHIP_CONFIG = "~/.config/starship/light.toml"
  $env.BAT_THEME = "Catppuccin Latte"
}

mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

fnm env --json | from json | load-env

$env.FNM_BIN = $"($env.FNM_DIR)/bin"
$env.FNM_MULTISHELL_PATH = $"($env.FNM_DIR)/nodejs"

path add $env.FNM_BIN
path add $env.FNM_MULTISHELL_PATH
path add $"($env.FNM_MULTISHELL_PATH)/bin"
path add ~/.orbstack/bin
path add /usr/local/bin
