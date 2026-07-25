#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
THUMB_DIR="$WALLPAPER_DIR/.thumbs"

# Auto-generate thumbnails for any new wallpaper — runs every launch,
# but skips files that already have a thumbnail, so it's near-instant
# once you've added everything once.
mkdir -p "$THUMB_DIR"
for img in "$WALLPAPER_DIR"/*.jpg "$WALLPAPER_DIR"/*.jpeg "$WALLPAPER_DIR"/*.png; do
    [ -f "$img" ] || continue
    name=$(basename "$img")
    [ -f "$THUMB_DIR/$name" ] || magick "$img" -gravity center -crop 9:16 +repage -resize 400x711^ "$THUMB_DIR/$name"
done

selected=$(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | \
    while read -r img; do
        name=$(basename "$img")
        thumb="$THUMB_DIR/$name"
        [ -f "$thumb" ] || thumb="$img"
        printf '%s\0icon\x1f%s\n' "$name" "$thumb"
    done | \
    rofi -dmenu -i -p "Wallpaper" -show-icons \
        -theme ~/.config/rofi/launchers/type-3/style-6.rasi
)

[ -z "$selected" ] && exit 0

WALLPAPER="$WALLPAPER_DIR/$selected"
[ -f "$WALLPAPER" ] && swww img "$WALLPAPER" --transition-type grow --transition-duration 1