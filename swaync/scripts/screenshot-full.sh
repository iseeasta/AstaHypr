#!/usr/bin/env bash
mkdir -p ~/Pictures/Screenshots
FILE="$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
grim "$FILE"
wl-copy < "$FILE"
notify-send "Screenshot" "Saved and copied: $(basename $FILE)"