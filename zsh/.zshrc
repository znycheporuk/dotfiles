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
setopt HIST_LEX_WORDS            # Use zsh's extended word parsing for history
setopt HIST_FIND_NO_DUPS         # Don't show duplicates when searching

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

# Carapace setup
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
autoload -U compinit
compinit
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# mcfly configuration
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=2

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
eval "$(mcfly init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias dcu='docker compose up'
alias dcd='docker compose down'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# eza (modern ls replacement)
alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'
alias tree='eza --tree'
alias lg='eza -l --git'




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

# Btop wrapper function that updates theme before launching
btop() {
    local btop_config="$HOME/.config/btop/btop.conf"

    if [[ -f "$btop_config" ]]; then
        # Follow symlink to get the actual file path
        local real_config=$(readlink -f "$btop_config")

        if is_dark_mode; then
            sed -i '' 's|catppuccin_latte\.theme"|catppuccin_mocha.theme"|g' "$real_config"
        else
            sed -i '' 's|catppuccin_mocha\.theme"|catppuccin_latte.theme"|g' "$real_config"
        fi
    fi

    command btop "$@"
}
