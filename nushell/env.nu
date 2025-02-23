use std "path add"

path add /opt/homebrew/bin
path add /home/vaibhavdn/.fnm

# Starship
def is_dark_mode [] {
  let appearance = (osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode') | str trim
  $appearance == "true"
}

if (is_dark_mode) {
  $env.STARSHIP_CONFIG = "/Users/nycheporuk/.config/starship/dark.toml"
  $env.BAT_THEME = "Catppuccin Mocha"
} else {
  $env.STARSHIP_CONFIG = "/Users/nycheporuk/.config/starship/light.toml"
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

# Function to find the closest node_modules/.bin directory
def find_closest_node_modules_bin [] {
  mut current_dir = (pwd)
  let home_dir = ($env.HOME)

  loop {
    let node_modules_bin = $"($current_dir)/node_modules/.bin"
    if ($node_modules_bin | path exists) {
      return $node_modules_bin
    }
    let parent_dir = ($current_dir | path dirname)
    if ($parent_dir == $current_dir or $current_dir == $home_dir) {
      break
    }
    $current_dir = $parent_dir
  }
  return ""
}

let closest_node_modules_bin = (find_closest_node_modules_bin)
if ($closest_node_modules_bin != "") {
  path add $closest_node_modules_bin
}
