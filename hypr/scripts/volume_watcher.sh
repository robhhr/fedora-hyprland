#!/bin/bash

last_vol=$(pamixer --get-volume)

while true; do
    sleep 0.5
    current_vol=$(pamixer --get-volume)
    if [ "$current_vol" != "$last_vol" ]; then
        muted=$(pamixer --get-mute)
        if [ "$muted" = "true" ]; then
            dunstify -r 9111 -t 1000 "Muted 🔇"
        else
            dunstify -r 9111 -t 1000 "Volume: ${current_vol}% 🔊"
        fi
        last_vol=$current_vol
    fi
done

