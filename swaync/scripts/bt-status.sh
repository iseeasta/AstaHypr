#!/usr/bin/env bash
if bluetoothctl show | grep -q "Powered: yes"; then
    echo true
else
    echo false
fi