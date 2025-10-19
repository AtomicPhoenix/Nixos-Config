#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
CHANGE_INTERNAL=60

readarray -d '' wallpapers < <(find "$WALLPAPER_DIR" -type f -print0)

while true; do
	for i in "${!wallpapers[@]}"; do
		wallpaper="${wallpapers[$i]}"
		echo "$wallpaper"
	done
	RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
	hyprctl hyprpaper preload "$RANDOM_WALLPAPER" &>/dev/null
	hyprctl hyprpaper wallpaper ", $RANDOM_WALLPAPER" &>/dev/null
	hyprctl hyprpaper unload "$RANDOM_WALLPAPER" &>/dev/null
	sleep "$CHANGE_INTERNAL"
done
