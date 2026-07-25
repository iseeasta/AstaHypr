#!/usr/bin/env bash
# Usage: ./generate-waybar-theme.sh nord

ROFI_DIR="$HOME/.config/rofi/colors"
WAYBAR_DIR="$HOME/.config/waybar/themes"
THEME="$1"
SRC="$ROFI_DIR/${THEME}.rasi"

[ -f "$SRC" ] || { echo "No such rofi theme: $THEME"; exit 1; }

get_color() {
    grep -m1 "$1:" "$SRC" | grep -oE '#[0-9A-Fa-f]{6,8}' | head -c 7
}

background=$(get_color "background")
background_alt=$(get_color "background-alt")
foreground=$(get_color "foreground")
selected=$(get_color "selected")
active=$(get_color "active")
urgent=$(get_color "urgent")


cat > "$WAYBAR_DIR/${THEME}.css" <<EOF
@define-color base     $background;
@define-color mantle   $background;
@define-color surface0 $background_alt;
@define-color surface1 $background_alt;
@define-color surface2 $background_alt;
@define-color text     $foreground;
@define-color subtext  $foreground;
@define-color lavender $selected;
@define-color blue     $selected;
@define-color sapphire $selected;
@define-color teal     $active;
@define-color green    $active;
@define-color yellow   $active;
@define-color peach    $urgent;
@define-color red      $urgent;
@define-color mauve    $selected;
@define-color pink     $selected;
EOF

echo "Generated $WAYBAR_DIR/${THEME}.css"