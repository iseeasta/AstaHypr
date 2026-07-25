#!/usr/bin/env bash
state=$(gsettings get org.gnome.system.location enabled)
if [ "$state" = "true" ]; then
    echo "󰍎 On"
else
    echo "󰍐 Off"
fi
