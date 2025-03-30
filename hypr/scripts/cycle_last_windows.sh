#!/bin/bash

set -x  # debug mode

clients=$(hyprctl clients -j | jq -c 'sort_by(.last_focus_time) | reverse | .[]')
current=$(hyprctl activewindow -j | jq -r '.address')

addr_array=()

while IFS= read -r client; do
    ws_name=$(echo "$client" | jq -r '.workspace.name')
    addr=$(echo "$client" | jq -r '.address')
    title=$(echo "$client" | jq -r '.title')
    class=$(echo "$client" | jq -r '.class')

    # fallback if workspace.name is null
    if [[ "$ws_name" == "null" ]]; then
        ws_name=""
    fi

    # skip if on hidden workspace
    if [[ "$ws_name" != "order66" ]]; then
        addr_array+=("$addr")
    fi
done <<< "$clients"

# if fewer than 2 valid windows
if [ ${#addr_array[@]} -lt 2 ]; then
    exit 0
fi

# toggle between top 2
if [[ "${addr_array[0]}" == "$current" ]]; then
    hyprctl dispatch focuswindow address:${addr_array[1]}
else
    hyprctl dispatch focuswindow address:${addr_array[0]}
fi

