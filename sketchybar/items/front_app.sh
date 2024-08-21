#!/bin/bash

source "$CONFIG_DIR/colors.sh"

sketchybar --add item front_app left \
           --set front_app       background.color=$COLOR_RED \
                                 icon.color=$BG_LABEL_COLOR_ALT \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 icon.padding_left=8 \
                                 label.color=$BG_LABEL_COLOR_ALT \
                                 label.padding_left=5 \
                                 label.padding_right=8 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched

