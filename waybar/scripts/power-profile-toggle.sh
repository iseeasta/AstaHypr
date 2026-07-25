#!/usr/bin/env bash

PROFILES=("balanced" "powersave" "desktop")
CURRENT=$(tuned-adm active | sed 's/Current active profile: //')

# Find index of current profile in our list
index=-1
for i in "${!PROFILES[@]}"; do
    if [ "${PROFILES[$i]}" = "$CURRENT" ]; then
        index=$i
        break
    fi
done

# Move to next profile in the list (wrap around)
next_index=$(( (index + 1) % ${#PROFILES[@]} ))
tuned-adm profile "${PROFILES[$next_index]}"
