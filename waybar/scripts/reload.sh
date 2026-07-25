#!/usr/bin/env bash

CONFIG="$HOME/.config/waybar"

inotifywait -m -r -e modify,create,delete,move --format '%w%f' "$CONFIG" |
while read -r file; do
    pkill -SIGUSR2 waybar
done