# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# History options
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_LEX_WORDS
setopt HIST_FIND_NO_DUPS

# PATH setup
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Theme configuration - always dark mode
export THEME_MODE="dark"
export STARSHIP_CONFIG="$HOME/.config/starship/dark.toml"
export BAT_THEME="Catppuccin Mocha"

# Tool initialization
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ls='eza --group-directories-first'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'
alias tree='eza --tree'
alias lg='eza -l --git'
alias cd='z'

export EDITOR='nvim'
