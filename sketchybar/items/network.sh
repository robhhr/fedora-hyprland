#!/bin/bash

sketchybar --add item network right \
  --set network script="$PLUGIN_DIR/network.sh" \
           update_freq=10 \
           background.padding_left=3 \
           icon.padding_left=8 \
           icon.padding_right=8 \

