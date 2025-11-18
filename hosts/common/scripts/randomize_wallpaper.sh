#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)
RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
hyprctl hyprpaper reload ,"$RANDOM_WALLPAPER"
