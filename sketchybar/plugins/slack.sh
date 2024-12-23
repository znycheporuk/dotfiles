#!/usr/bin/env sh
source "$CONFIG_DIR/colors.sh"
STATUS_LABEL=$(lsappinfo info -only StatusLabel "Slack")
ICON="󰒱"
if [[ $STATUS_LABEL =~ \"label\"=\"([^\"]*)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"

    case "$LABEL" in
        "")
            ICON_COLOR="$TEXT_COLOR"
            ;;
        "•")
            LABEL=""
            ICON_COLOR="$YELLOW"
            ;;
        [0-9]*)
            ICON_COLOR="$MAUVE"
            ;;
        *)
            sketchybar --set $NAME drawing=off
            exit 0
            ;;
    esac
else
  sketchybar --set $NAME drawing=off
  exit 0
fi

sketchybar --set $NAME drawing=on icon=$ICON label="${LABEL}" icon.color=${ICON_COLOR}
