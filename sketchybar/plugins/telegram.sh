#!/usr/bin/env sh
source "$CONFIG_DIR/colors.sh"
STATUS_LABEL=$(lsappinfo info -only StatusLabel "Telegram")
ICON=""
if [[ $STATUS_LABEL =~ \"label\"=\"[^0-9]*([0-9]+)\" ]]; then
    LABEL="${BASH_REMATCH[1]}"
    case "$LABEL" in
        [0-9]*)
            ICON_COLOR="$BLUE"
            ;;
        *)
            sketchybar --set $NAME drawing=off
            exit 0
            ;;
    esac
elif [[ $STATUS_LABEL =~ \"label\"=\"\" ]]; then
  LABEL=""
  ICON_COLOR="$TEXT_COLOR"
else
  sketchybar --set $NAME drawing=off
  exit 0
fi

sketchybar --set $NAME drawing=on icon=$ICON label="${LABEL}" icon.color=${ICON_COLOR}
