#!/bin/bash

RECORDING_PID_FILE="/tmp/hypr-recording.pid"
OUTPUT="$HOME/Videos/recording_$(date +%s).mp4"

if [ -f "$RECORDING_PID_FILE" ]; then
    # stop recording
    kill "$(cat "$RECORDING_PID_FILE")"
    rm "$RECORDING_PID_FILE"
    notify-send "🛑 recording stopped"
else
    # start recording
    GEOM=$(slurp)
    wf-recorder -g "$GEOM" -f "$OUTPUT" &
    echo $! > "$RECORDING_PID_FILE"
    notify-send "🎥 recording started"
fi

