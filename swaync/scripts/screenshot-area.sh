#!/usr/bin/env bash
grim -g "$(slurp)" - | wl-copy
notify-send "Screenshot" "Area copied to clipboard"