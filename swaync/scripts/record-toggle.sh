#!/usr/bin/env bash
mkdir -p ~/Videos/Recordings
PIDFILE="/tmp/wf-recorder.pid"

if [ -f "$PIDFILE" ]; then
    kill -INT "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    notify-send "Recording" "Stopped"
else
    FILE="$HOME/Videos/Recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4"
    wf-recorder -f "$FILE" &
    echo $! > "$PIDFILE"
    notify-send "Recording" "Started: $(basename $FILE)"
fi