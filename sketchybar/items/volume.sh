#!/bin/bash

sketchybar --add item volume right \
           --set volume script="$PLUGIN_DIR/volume.sh" \
           icon.padding_left=8 \
           icon.padding_right=5 \
           label.padding_right=5 \
           --subscribe volume volume_change \

