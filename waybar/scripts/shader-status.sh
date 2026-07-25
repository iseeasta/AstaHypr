#!/usr/bin/env bash
HYPRSHADE="$HOME/.local/bin/hyprshade"
current=$("$HYPRSHADE" current 2>/dev/null)
if [ -z "$current" ]; then
    echo "󰃟 None"
else
    echo "󰛨 $current"
fi