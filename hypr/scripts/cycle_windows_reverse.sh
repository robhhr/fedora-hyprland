#!/bin/bash

# get all window addresses sorted by last focus time
addresses=$(hyprctl clients -j | jq -r 'sort_by(.last_focus_time) | reverse | .[].address')

# get current focused window & convert to array
current=$(hyprctl activewindow -j | jq -r '.address')
addr_array=($addresses)

# find index of current window
for i in "${!addr_array[@]}"; do
    if [[ "${addr_array[$i]}" == "$current" ]]; then
        prev_index=$(( (i - 1 + ${#addr_array[@]}) % ${#addr_array[@]} ))
        hyprctl dispatch focuswindow address:${addr_array[$prev_index]}
        break
    fi
done

