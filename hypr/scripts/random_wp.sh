#!/bin/bash
WP_DIR="$HOME/Pictures/Wallpapers"

MONITORS=( $(hyprctl monitors -j | jq -r '.[].name') )

for monitor in "${MONITORS[@]}"; do
    pic=$(find "$WP_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)
    hyprctl hyprpaper preload "$pic" 2>/dev/null
    hyprctl hyprpaper wallpaper "$monitor,$pic" 2>/dev/null
done
