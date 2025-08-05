get_kbd_connected() {
  case $(lsusb | grep -c "0b05:1b2c") in
  0)
    echo 0
    ;;
  *)
    echo 1
    ;;
  esac
}

toggle_monitor() {
  if [[ $(get_kbd_connected) -eq 1 ]]; then
    notify-send "Disabling Second Monitor"
    hyprctl keyword monitor "eDP-2, disable"
  else
    notify-send "Enabling Second Monitor"
    hyprctl keyword monitor "eDP-2, 2880x1800@120.0Hz, 0x900, 2"
  fi
}

toggle_monitor
while inotifywait -e attrib /dev/bus/usb/*/; do
  toggle_monitor
done
