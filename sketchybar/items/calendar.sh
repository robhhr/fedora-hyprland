#!/bin/bash

sketchybar --add item calendar right \
           --set calendar icon=   \
                          update_freq=30 \
                          icon.color=0xffffff00 \
                          script="$PLUGIN_DIR/calendar.sh"

