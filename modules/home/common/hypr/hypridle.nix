_: {
  services.hypridle = {
    enable = true;
    settings = {
      # General settings for what to do when certain global events / signals occur (e.g. lock_cmd runs when a lock signal is heard)
      general = {
        lock_cmd = "pidof hyprlock || hyprlock;"; # Avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session;";
        after_sleep_cmd = "hyprctl dispatch dpms on;";
        ignore_dbus_inhibit = false; # Don't ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
        ignore_systemd_inhibit = false; # Don't ignore systemd-inhibit --what=idle inhibitors
        ignore_wayland_inhibit = false; # Don't ignore wayland protocol inhibition requests (e.g. from running video players)
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "loginctl lock-session;";
        }
        {
          timeout = 180;
          on-timeout = "(systemd-ac-power && set-brightness 50%) || hyprctl dispatch dpms off"; # Turns DPMS off when on battery
          on-resume = "hyprctl dispatch dpms on; set-brightness 100%";
        }
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 360;
          on-timeout = "loginctl suspend";
        }
      ];
    };
  };
}
