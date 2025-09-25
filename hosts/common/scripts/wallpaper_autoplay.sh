#!/usr/bin/env bash

wallpapers=$(find ~/Pictures/Wallpapers/*)
wallpaperCount="$(echo "$wallpapers" | wc -w)"

function unload() {
	hyprctl hyprpaper unload "$1" &>/dev/null
}

function preload() {
	hyprctl hyprpaper preload "$1" &>/dev/null
}

function setwp() {
	hyprctl hyprpaper wallpaper ", $1" &>/dev/null
}

while :; do
	for i in $(seq 1 "$wallpaperCount"); do
		bg="$(echo "$wallpapers" | sed -n "$i"'p')"
		preload "$bg"
		sleep 5
		setwp "$bg"
		unload "$bg"
		sleep 55
	done
done
