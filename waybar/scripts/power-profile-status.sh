#!/usr/bin/env bash

CURRENT=$(tuned-adm active | sed 's/Current active profile: //')

case "$CURRENT" in
    balanced)
        echo " Balanced"
        ;;
    powersave)
        echo " Power Saver"
        ;;
    desktop)
        echo "🖥 Desktop"
        ;;
    *)
        echo "⚙ $CURRENT"
        ;;
esac