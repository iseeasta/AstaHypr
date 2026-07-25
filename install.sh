#!/usr/bin/env bash
set -e

echo "Installing dependencies..."
sudo dnf install -y hyprland waybar rofi swaync kitty thunar wlogout \
    swww grim slurp wf-recorder ffmpeg-free jq bc bluez bluez-tools \
    tuned power-profiles-daemon --skip-broken

pip install --break-system-packages hyprshade

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "Backing up existing configs..."
mkdir -p "$HOME/.config-backup-$(date +%Y%m%d)"
for dir in hypr waybar rofi swaync kitty; do
    if [ -d "$CONFIG_DIR/$dir" ]; then
        mv "$CONFIG_DIR/$dir" "$HOME/.config-backup-$(date +%Y%m%d)/"
    fi
done

echo "Symlinking configs..."
ln -sf "$DOTFILES_DIR/hypr" "$CONFIG_DIR/hypr"
ln -sf "$DOTFILES_DIR/waybar" "$CONFIG_DIR/waybar"
ln -sf "$DOTFILES_DIR/rofi" "$CONFIG_DIR/rofi"
ln -sf "$DOTFILES_DIR/swaync" "$CONFIG_DIR/swaync"
ln -sf "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

mkdir -p "$CONFIG_DIR/gtk-3.0"
cp "$DOTFILES_DIR/gtk-3.0/gtk.css" "$CONFIG_DIR/gtk-3.0/gtk.css"

chmod +x "$CONFIG_DIR/waybar/scripts/"*.sh
chmod +x "$CONFIG_DIR/swaync/scripts/"*.sh

echo "Done. Log out and select Hyprland (uwsm) session to apply."
