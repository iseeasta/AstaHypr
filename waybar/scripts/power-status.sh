#!/usr/bin/env bash

profile=$(powerprofilesctl get 2>/dev/null || echo "balanced")

case "$profile" in
    performance)
        icon="󰓅"
        class="performance"
        mode="Performance"
        ;;
    balanced)
        icon="󰾅"
        class="balanced"
        mode="Balanced"
        ;;
    power-saver)
        icon="󰾆"
        class="power-saver"
        mode="Power Saver"
        ;;
    *)
        icon="󰾅"
        class="balanced"
        mode="Balanced"
        ;;
esac

tooltip="$mode Mode

󰍹 Left Click  → Change Profile
󰌾 Right Click → Lock Screen
󰒲 Middle Click → Suspend

󰜮 Scroll Up   → Performance
󰜷 Scroll Down → Power Saver"

printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' \
    "$icon" "$class" "$tooltip"