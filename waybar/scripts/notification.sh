#!/usr/bin/env bash

# Waybar notification module
# Requires: swaync

COUNT=$(swaync-client -c 2>/dev/null)

# Check Do Not Disturb status
DND=$(swaync-client -D 2>/dev/null)

if [ "$DND" = "true" ]; then
    echo '{
        "text": "󰂛",
        "tooltip": "Do Not Disturb Enabled\nClick to open notifications",
        "class": "dnd"
    }'
    exit 0
fi


# No notifications
if [ "$COUNT" = "0" ] || [ -z "$COUNT" ]; then
    echo '{
        "text": "󰂚",
        "tooltip": "No new notifications\nClick to open center",
        "class": "empty"
    }'

# Few notifications
elif [ "$COUNT" -lt 5 ]; then
    echo "{
        \"text\": \"󰂚 $COUNT\",
        \"tooltip\": \"$COUNT notifications waiting\",
        \"class\": \"low\"
    }"

# Many notifications
elif [ "$COUNT" -lt 15 ]; then
    echo "{
        \"text\": \"󰂚 $COUNT\",
        \"tooltip\": \"$COUNT notifications waiting\",
        \"class\": \"medium\"
    }"

# Lots of notifications
else
    echo "{
        \"text\": \"󰂛 $COUNT\",
        \"tooltip\": \"$COUNT notifications waiting\",
        \"class\": \"high\"
    }"
fi