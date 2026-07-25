#!/usr/bin/env bash

WAYBAR_DIR="$HOME/.config/waybar/themes"
ROFI_DIR="$HOME/.config/rofi/colors"
WALLPAPER_DIR="$HOME/Pictures/wallpapers/themes"
SWAYNC_CSS="$HOME/.config/swaync/style.css"

GENERATOR="$HOME/.config/waybar/scripts/generate-waybar-theme.sh"

# Auto-generate any missing Waybar theme files from rofi colors
for rofi_file in "$ROFI_DIR"/*.rasi; do
    [ -f "$rofi_file" ] || continue
    name=$(basename "$rofi_file" .rasi)
    [ "$name" = "current" ] && continue
    if [ ! -f "$WAYBAR_DIR/${name}.css" ]; then
        "$GENERATOR" "$name"
    fi
done

THEME=$(find "$WAYBAR_DIR" -maxdepth 1 -name "*.css" \
    ! -name "current.css" ! -name "structure.css" \
    -printf "%f\n" | sed 's/\.css$//' \
    | rofi -dmenu -p "Waybar Theme" -theme ~/.config/rofi/launchers/type-1/style-3.rasi)

[ -z "$THEME" ] && exit 0

# Update Waybar
cp "$WAYBAR_DIR/${THEME}.css" "$WAYBAR_DIR/current.css"

# Update Rofi (only if a matching rofi color file exists)
if [ -f "$ROFI_DIR/${THEME}.rasi" ]; then
    cp "$ROFI_DIR/${THEME}.rasi" "$ROFI_DIR/current.rasi"
fi

# Update Wallpaper (only if a matching wallpaper file exists)
WALLPAPER=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f -iname "${THEME}.*" | head -n1)
[ -n "$WALLPAPER" ] && swww img "$WALLPAPER" --transition-type wave --transition-duration 1

# Update SwayNC colors from the same theme file
if [ -f "$WAYBAR_DIR/${THEME}.css" ] && [ -f "$SWAYNC_CSS" ]; then
    base=$(grep "base" "$WAYBAR_DIR/${THEME}.css" | head -1 | grep -oE '#[0-9A-Fa-f]{6}')
    text=$(grep "text " "$WAYBAR_DIR/${THEME}.css" | head -1 | grep -oE '#[0-9A-Fa-f]{6}')
    lavender=$(grep "lavender" "$WAYBAR_DIR/${THEME}.css" | head -1 | grep -oE '#[0-9A-Fa-f]{6}')

    if [ -n "$base" ] && [ -n "$text" ]; then
        sed -i \
            -e "s/--cc-bg: rgba([0-9, .]*);/--cc-bg: ${base}E0;/" \
            -e "s/--text-color: rgb([0-9, ]*);/--text-color: ${text};/" \
            "$SWAYNC_CSS"
    fi
fi

# Update Waybar
killall waybar; waybar &

# Update SwayNC
swaync-client --reload-config --reload-css

# Update Kitty
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
if [ -f "$ROFI_DIR/${THEME}.rasi" ]; then
    bg=$(grep -m1 "background:" "$ROFI_DIR/${THEME}.rasi" | grep -oE '#[0-9A-Fa-f]{6}')
    fg=$(grep -m1 "foreground:" "$ROFI_DIR/${THEME}.rasi" | grep -oE '#[0-9A-Fa-f]{6}')
    sel=$(grep -m1 "selected:" "$ROFI_DIR/${THEME}.rasi" | grep -oE '#[0-9A-Fa-f]{6}')
    act=$(grep -m1 "active:" "$ROFI_DIR/${THEME}.rasi" | grep -oE '#[0-9A-Fa-f]{6}')
    urg=$(grep -m1 "urgent:" "$ROFI_DIR/${THEME}.rasi" | grep -oE '#[0-9A-Fa-f]{6}')

    cat > "$KITTY_CONF" <<EOF
background $bg
foreground $fg
selection_background $sel
selection_foreground $bg
cursor $sel
color0  $bg
color8  $bg
color1  $urg
color9  $urg
color2  $act
color10 $act
color4  $sel
color12 $sel
color5  $sel
color13 $sel
color6  $act
color14 $act
color7  $fg
color15 $fg
EOF
    kitty @ set-colors -a "$KITTY_CONF" 2>/dev/null
fi



# Update Nautilus / GNOME accent
declare -A GNOME_ACCENT_MAP=(
    [red]="red"
    [blue]="blue"
    [green]="green"
    [pink]="pink"
    [nord]="blue"
    [dracula]="purple"
    [gruvbox]="orange"
    [everforest]="green"
    [solarized]="teal"
    [catppuccin]="pink"
    [tokyonight]="purple"
    [onedark]="blue"
    [cyberpunk]="pink"
    [black]="slate"
    [navy]="blue"
    [paper]="slate"
    [lovelace]="purple"
    [yousai]="orange"
    [arc]="blue"
    [adapta]="teal"
)

accent="${GNOME_ACCENT_MAP[$THEME]:-slate}"
gsettings set org.gnome.desktop.interface accent-color "$accent"
