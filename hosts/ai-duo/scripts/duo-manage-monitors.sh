#!/usr/bin/env bash
toggle-monitor
while inotifywait -e attrib /dev/bus/usb/*/; do
  toggle-monitor
done
