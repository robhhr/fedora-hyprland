#!/bin/bash

# window addresses sorted by most recent focus
addresses=$(hyprctl clients -j | jq -r 'sort_by(.last_focus_time) | reverse | .[].address')

# get the currently focused window address & convert to array
current=$(hyprctl activewindow -j | jq -r '.address')
addr_array=($addresses)

# find index of current window
for i in "${!addr_array[@]}"; do
    if [[ "${addr_array[$i]}" == "$current" ]]; then
        next_index=$(( (i + 1) % ${#addr_array[@]} ))
        hyprctl dispatch focuswindow address:${addr_array[$next_index]}
        break
    fi
done

