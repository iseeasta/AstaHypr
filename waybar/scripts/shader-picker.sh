#!/usr/bin/env bash

HYPRSHADE="$HOME/.local/bin/hyprshade"

CURRENT=$("$HYPRSHADE" current 2>/dev/null)

OPTIONS="none
blue-light-filter
vibrance
invert"

CHOICE=$(echo "$OPTIONS" | rofi -dmenu -i -p "Shader" -theme ~/.config/rofi/launchers/type-1/style-10.rasi)

[ -z "$CHOICE" ] && exit 0

if [ "$CHOICE" = "none" ]; then
    "$HYPRSHADE" off
    notify-send "Shader" "Disabled"
else
    "$HYPRSHADE" on "$CHOICE"
    notify-send "Shader" "Enabled: $CHOICE"
fi