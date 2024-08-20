#!/bin/bash

INTERFACE=$(ifconfig | grep -Eo 'ppp0|tun0|utun0<your_interface>')

if [ -n "$INTERFACE" ]; then
  sketchybar --set $NAME label="connected" icon="🔒"
else
  sketchybar --set $NAME label="disconnected" icon="🔓"
fi

