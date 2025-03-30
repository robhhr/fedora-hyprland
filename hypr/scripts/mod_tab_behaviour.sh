#!/bin/bash

read -t 0.3 -N 1 -s input

if [[ -n "$input" ]]; then
    ~/.config/hypr/scripts/cycle_last_windows.sh
else
    ~/.config/hypr/scripts/app_switcher.sh
fi

