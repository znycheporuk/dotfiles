$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | prepend "/home/vaibhavdn/.fnm")

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
