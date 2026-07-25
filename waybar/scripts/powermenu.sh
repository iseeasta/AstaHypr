#!/usr/bin/env bash

# ---------------------------------------------------------
# Power Menu for Hyprland
# Dependencies:
# rofi, hyprlock, systemctl, notify-send, canberra-gtk-play
# ---------------------------------------------------------

# Icons (Nerd Font)
LOCK="󰌾  Lock"
LOGOUT="󰍃  Logout"
SUSPEND="󰤄  Suspend"
HIBERNATE="󰒲  Hibernate"
REBOOT="󰜉  Reboot"
SHUTDOWN="󰐥  Shutdown"

# Optional sound
play_sound() {
    command -v canberra-gtk-play >/dev/null &&
        canberra-gtk-play -i dialog-information &
}

# Optional notification
notify() {
    command -v notify-send >/dev/null &&
        notify-send "Power Menu" "$1"
}

CHOICE=$(printf "%s\n%s\n%s\n%s\n%s\n%s" \
"$LOCK" \
"$LOGOUT" \
"$SUSPEND" \
"$HIBERNATE" \
"$REBOOT" \
"$SHUTDOWN" | \
rofi \
    -dmenu \
    -i \
    -p "Power" \
    -theme ~/.config/rofi/powermenu.rasi)

case "$CHOICE" in

    "$LOCK")
        notify "Locking session..."
        play_sound
        sleep 0.2
        hyprlock
        ;;

    "$LOGOUT")
        notify "Logging out..."
        play_sound
        sleep 0.2
        hyprctl dispatch exit
        ;;

    "$SUSPEND")
        notify "Suspending..."
        play_sound
        sleep 0.5
        systemctl suspend
        ;;

    "$HIBERNATE")
        notify "Hibernating..."
        play_sound
        sleep 0.5
        systemctl hibernate
        ;;

    "$REBOOT")
        notify "Rebooting..."
        play_sound
        sleep 0.5
        systemctl reboot
        ;;

    "$SHUTDOWN")
        notify "Shutting down..."
        play_sound
        sleep 0.5
        systemctl poweroff
        ;;

esac