#!/usr/bin/env bash
current=$(gsettings get org.gnome.system.location enabled)
if [ "$current" = "true" ]; then
    gsettings set org.gnome.system.location enabled false
    notify-send "Location" "Disabled"
else
    gsettings set org.gnome.system.location enabled true
    notify-send "Location" "Enabled"
fi
