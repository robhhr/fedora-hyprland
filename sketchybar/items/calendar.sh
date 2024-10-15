#!/bin/bash

sketchybar --add item calendar right \
           --set calendar update_freq=30 \
                          label.padding_left=8 \
                          label.padding_right=8 \
                          background.padding_left=3 \
                          script="$PLUGIN_DIR/calendar.sh"

