#!/bin/bash

choice=$(echo -e "shutdown\nreboot\nsuspend\nlogout" | wofi --show dmenu --width 200 --height 140 --prompt "" --dmenu)

case "$choice" in
    shutdown)
        systemctl poweroff
        ;;
    reboot)
        systemctl reboot
        ;;
    suspend)
        systemctl suspend
        ;;
    logout)
        hyprctl dispatch exit
        ;;
esac

