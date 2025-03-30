#!/bin/bash

clients=$(hyprctl clients -j | jq -c 'sort_by(.last_focus_time) | reverse | .[]')

menu=""
declare -A address_map

while IFS= read -r client; do
    ws_name=$(echo "$client" | jq -r '.workspace.name')
    addr=$(echo "$client" | jq -r '.address')
    title=$(echo "$client" | jq -r '.title')
    class=$(echo "$client" | jq -r '.class')

    # Skip hidden or order66 workspace windows
    if [[ "$ws_name" == "null" || "$ws_name" == "order66" ]]; then
        continue
    fi

    label="${title} (${class})"
    menu+="${label}"$'\n'
    address_map["$label"]="$addr"
done <<< "$clients"

# Show menu via wofi
selection=$(echo "$menu" | wofi --dmenu --prompt "Switch to:")

# Dispatch focus
if [[ -n "$selection" ]]; then
    selected_addr=${address_map["$selection"]}
    if [[ -n "$selected_addr" ]]; then
        hyprctl dispatch focuswindow address:"$selected_addr"
    fi
fi

