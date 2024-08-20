#!/bin/bash

source "$CONFIG_DIR/colors.sh"

IS_VPN=$(ifconfig | grep -Eo 'ppp0|tun0|utun0<your_interface>')
IP_ADDRESS=$(scutil --nwi | grep address | sed 's/.*://' | tr -d ' ' | head -1)

if [ -n "$IS_VPN" ]; then
    ICON=""
    ICON_COLOR=$NETWORK_GREEN
elif [[ $IP_ADDRESS != "" ]]; then
    ICON=""
    ICON_COLOR=$WHITE
else
    ICON="󰖪"
    ICON_COLOR=$NETWORK_RED
fi

sketchybar --set $NAME icon="${ICON}" icon.color="${ICON_COLOR}" label="${IP_ADDRESS}"

