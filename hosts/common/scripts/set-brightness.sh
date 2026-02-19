#!/usr/bin/env bash
usage() {
  printf "Usage: %s <brightness>\n" "$(basename "$0")"
  printf "Examples:\n\t%s 10%%\n\t%s +5%%\n\t%s 200\n" "$(basename "$0")" "$(basename "$0")" "$(basename "$0")"
  exit 1
}

BRIGHTMOD="$1"

# Make sure there is one argument
[[ $# -eq 1 ]] || usage

# Confirm argument follows formatting
if ! [[ "$BRIGHTMOD" =~ ^[0-9]+%?[+-]?$ ]]; then
  printf "Invalid brightness format: %s\n" "$BRIGHTMOD"
  usage
fi

# Loop through each backlight device and set brightness
BACKLIGHT_DEVICES=$(brightnessctl -l | grep "class 'backlight'" | awk -F"'" '{print $2}')
for DEVICE in $BACKLIGHT_DEVICES; do
  brightnessctl -d "$DEVICE" s "$BRIGHTMOD"
done
