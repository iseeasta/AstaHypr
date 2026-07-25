#!/usr/bin/env bash
if rfkill list | grep -q "Soft blocked: yes"; then
    echo true
else
    echo false
fi
