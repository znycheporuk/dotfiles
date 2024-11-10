#!/bin/sh

if ! grep -q "/opt/homebrew/bin/nu" /etc/shells; then
  echo "Adding Nushell to /etc/shells..."
  sudo sh -c 'echo /opt/homebrew/bin/nu >> /etc/shells'
fi

current_shell=$(dscl . -read ~/ UserShell | awk '{print $2}')
if [ "$current_shell" != "/opt/homebrew/bin/nu" ]; then
  chsh -s /opt/homebrew/bin/nu
  echo "Default shell changed to Nushell. Please log out and log back in to apply the changes."
fi
