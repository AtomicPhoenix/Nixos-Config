_: {
  services.hypridle = {
    enable = true;
    settings = {
      # General settings for what to do when certain global events / signals occur (e.g. lock_cmd runs when a lock signal is heard)
      general = {
        lock_cmd = "pidof hyprlock || hyprlock &;"; # avoid starting multiple hyprlock instances.
        before_sleep_cmd = "loginctl lock-session;";
        after_sleep_cmd = ''
          hyprctl dispatch dpms on;
          nmcli radio wifi on;
          brightnessctl -d intel_backlight s 100%;
          brightnessctl -d card1-eDP-2-backlight s $(brightnessctl -d intel_backlight g);
        '';
        ignore_dbus_inhibit = false; # Don't ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
        ignore_systemd_inhibit = false; # Don't ignore systemd-inhibit --what=idle inhibitors
        ignore_wayland_inhibit = false; # Don't ignore wayland protocol inhibition requests (e.g. from running video players)
      };
      listener = [
        {
          timeout = 120;
          on-timeout = "brightnessctl -d intel_backlight s 30% &&  brightnessctl -d card1-eDP-2-backlight s $(brightnessctl -d intel_backlight g)";
          on-resume = "brightnessctl -d intel_backlight s 100% &&  brightnessctl -d card1-eDP-2-backlight s $(brightnessctl -d intel_backlight g)";
        }
        {
          timeout = 240;
          on-timeout = "loginctl lock-session;";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 300;
          on-timeout = "systemd-ac-power || hyprctl dispatch dpms off"; # Turns DPMS off when on battery
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = "loginctl suspend";
        }
      ];
    };
  };
}
