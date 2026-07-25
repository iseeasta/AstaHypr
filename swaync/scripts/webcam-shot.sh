#!/usr/bin/env bash
mkdir -p ~/Pictures/Webcam
FILE="$HOME/Pictures/Webcam/$(date +%Y-%m-%d_%H-%M-%S).jpg"
ffmpeg -y -f v4l2 -i /dev/video0 -frames:v 1 "$FILE" 2>/dev/null
if [ -f "$FILE" ]; then
    wl-copy < "$FILE"
    notify-send "Webcam" "Photo saved and copied: $(basename $FILE)"
else
    notify-send "Webcam" "Failed to capture — check camera device"
fi