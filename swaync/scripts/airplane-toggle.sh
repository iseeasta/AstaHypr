#!/usr/bin/env bash
if rfkill list | grep -q "Soft blocked: yes"; then
    rfkill unblock all
    notify-send "Airplane Mode" "Disabled"
else
    rfkill block all
    notify-send "Airplane Mode" "Enabled"
fi
