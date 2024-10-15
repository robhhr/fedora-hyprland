#!/bin/bash

source "$CONFIG_DIR/colors.sh"

sketchybar --add item media right \
           --set media label.color=$BG_COLOR \
                       label.max_chars=20 \
                       background.color=$COLOR_YELLOW_ALT \
                       background.border_width=2 \
                       background.border_color=$COLOR_RED \
                       background.padding_left=10 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon=􀑪             \
                       icon.color=$BG_COLOR   \
                       icon.padding_left=8 \
                       icon.padding_right=4 \
                       script="$PLUGIN_DIR/media.sh" \
           --subscribe media media_change

