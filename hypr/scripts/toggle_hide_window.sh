#!/usr/bin/env bash

stack_file="/tmp/hide_window_pid_stack.txt"

function hide_window() {
    pid=$(hyprctl activewindow -j | jq '.pid')
    if [ -n "$pid" ]; then
        hyprctl dispatch movetoworkspacesilent name:order66,pid:$pid
        echo $pid >> $stack_file
    fi
}

function show_window() {
    pid=$(tail -1 $stack_file)
    if [ -n "$pid" ]; then
        sed -i '$d' $stack_file
        current_workspace=$(hyprctl activeworkspace -j | jq '.id')
        hyprctl dispatch movetoworkspacesilent $current_workspace,pid:$pid
    fi
}

# echo "Arg: $1" >> /tmp/hide_window_debug.log to check debug

if [ "$1" == "h" ]; then
    hide_window
elif [ "$1" == "s" ]; then
    show_window
fi

