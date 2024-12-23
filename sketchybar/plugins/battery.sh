#!/bin/sh
source "$CONFIG_DIR/colors.sh"
PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"
ICON_COLOR="$TEXT_COLOR"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON="" ICON_COLOR="$YELLOW"
  ;;
  *) ICON="" ICON_COLOR="$RED"
  ;;
esac

if [[ "$CHARGING" != "" ]]; then
  # ICON=""
  ICON_COLOR="$GREEN"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON"  label="${PERCENTAGE}%" icon.color=${ICON_COLOR}
