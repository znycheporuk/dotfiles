# Zsh Configuration - Clean and focused setup

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History options - only remove sequential duplicates
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry
setopt SHARE_HISTORY             # Share history between all sessions

# PATH setup
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.orbstack/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Dark mode detection for starship themes
is_dark_mode() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        local appearance=$(osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode' 2>/dev/null)
        [[ "$appearance" == "true" ]]
    else
        return 1
    fi
}

# Set starship config and bat theme based on dark mode
if is_dark_mode; then
    export STARSHIP_CONFIG="$HOME/.config/starship/dark.toml"
    export BAT_THEME="Catppuccin Mocha"
else
    export STARSHIP_CONFIG="$HOME/.config/starship/light.toml"
    export BAT_THEME="Catppuccin Latte"
fi

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# Aliases
alias dcu='docker compose up'
alias dcd='docker compose down'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'



# Function to find and add closest node_modules/.bin to PATH
add_node_modules_to_path() {
    # Remove any existing node_modules/.bin paths from PATH
    export PATH=$(echo $PATH | tr ':' '\n' | grep -v 'node_modules/.bin' | tr '\n' ':' | sed 's/:$//')

    # Find closest node_modules/.bin directory
    local current_dir="$PWD"
    local home_dir="$HOME"

    while [[ "$current_dir" != "$home_dir" && "$current_dir" != "/" ]]; do
        if [[ -d "$current_dir/node_modules/.bin" ]]; then
            export PATH="$current_dir/node_modules/.bin:$PATH"
            break
        fi
        current_dir=$(dirname "$current_dir")
    done
}

# Auto-run when changing directories
chpwd() {
    add_node_modules_to_path
}

# Run once on shell startup
add_node_modules_to_path
