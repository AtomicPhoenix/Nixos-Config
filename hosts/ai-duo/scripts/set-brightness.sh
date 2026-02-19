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

brightnessctl -d intel_backlight s "$BRIGHTMOD"

# Set bottom monitor brightness equal to top
TOP_CURRENT="$(brightnessctl -d intel_backlight g)"
brightnessctl -d card1-eDP-2-backlight s "$TOP_CURRENT"
