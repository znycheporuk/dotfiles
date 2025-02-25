#!/bin/sh

# Change the default terminal to Ghostty
defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
  '{ LSHandlerRoleAll = "com.mitchellh.ghostty"; LSHandlerURLScheme = "file"; }'

# Expand print panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForPrintMode2 -bool true

# Expand save panel by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Keyboard
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}'

# Disable the "Are you sure you want to open this application?" dialog.
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Always open new documents in tabs.
defaults write NSGlobalDomain AppleWindowTabbingMode always

# Text correction
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false  # Disable peroid substitution.
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false   # Disable smart quotes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false    # Disable smart dashes.
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false      # Disable automatic capitalization.
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false  # Disable auto-correct.
defaults write NSGlobalDomain NSAutomaticTextCompletionEnabled -bool false      # Disable text-completion.

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true                 # Show hidden files.
defaults write NSGlobalDomain AppleShowAllExtensions -bool true              # Show all file extensions.
defaults write com.apple.finder FXEnableExtensionsChangeWarning -bool false  # Disable file extension change warning.
defaults write com.apple.finder ShowRecentTags -bool false                   # Hide tags in sidebar.
defaults write com.apple.finder QuitMenuItem -bool true                      # Allow quitting finder via ⌘ + Q.
defaults write com.apple.finder SidebarWidth -int 175                        # Greater sidebar width.
defaults write com.apple.finder WarnOnEmptyTrash -bool false                 # No warning before emptying trash.

# Set search scope.
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope SCcf

# Set preferred view style.
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
defaults write com.apple.finder FXPreferredViewStyle clmv
rm -rf ~/.DS_Store

# Set default path for new windows.
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget PfHm
killall Finder

# Hide menu bar, so there is space for the status bar. Have to restart to take effect.
defaults write 'Apple Global Domain' AppleMenuBarVisibleInFullscreen -bool false
defaults write 'Apple Global Domain' _HIHideMenuBar -bool true

# Dock
defaults write com.apple.dock expose-group-apps -bool true # Group windows by application, so aerospace workspaces are properly shown.
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false
# Disable hot corners
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0

apps=(
  "/Applications/Telegram Desktop.app"
  "/Applications/Zen.app"
  "/Applications/Zed.app"
  "/Applications/Ghostty.app"
  "/Applications/Slack.app"
)

for app in "${apps[@]}"; do
  defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

killall Dock
