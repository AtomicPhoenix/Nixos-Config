#!/usr/bin/env bash
if [[ $(get-kbd-connected) -eq 1 ]]; then
  notify-send "Disabling Second Monitor"
  hyprctl keyword monitor "eDP-2, disable"
else
  notify-send "Enabling Second Monitor"
  hyprctl keyword monitor "eDP-2, 2880x1800@120.0Hz, 0x900, 2"
fi
