#!/bin/bash

source "$CONFIG_DIR/colors.sh"

IS_VPN=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')
IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)

if [ -n "$IS_VPN" ]; then
    ICON=""
    ICON_COLOR=$NETWORK_GREEN
elif [[ $IP_ADDRESS != "" ]]; then
    ICON=""
    ICON_COLOR=$COLOR_RED
else
    ICON="󰖪"
    ICON_COLOR=$NETWORK_RED
fi

sketchybar --set $NAME icon="${ICON}" icon.color="${ICON_COLOR}" label=""

