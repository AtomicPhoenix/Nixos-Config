{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      background = {
        path = "/home/ai/Pictures/Wallpapers/aki.png";
      };

      # GENERAL
      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = false;
        grace = 0;
        disable_loading_bar = true;
        ignore_empty_input = true;
      };

      # INPUT FIELD
      input-field = {
        size = "400, 50";
        position = "0, 10";
        dots_center = true;
        fade_on_empty = false;
        font_color = "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "Password...";
        shadow_passes = 2;
      };

      label = let
        date = {
          text = "cmd[update:1000] echo \"$(date +\"%A, %B %d\")\"";
          color = "rgba(242, 243, 244, 1)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        };

        time = {
          text = "cmd[update:1000] echo \"$(date +\"%-I:%M\")\"";
          color = "rgba(242, 243, 244, 1)";
          font_size = 95;
          font_family = "JetBrains Mono Extrabold";
          position = "0, 200";
          halign = "center";
          valign = "center";
        };

        battery = {
          # monitor =
          text = "cmd[update:1000] echo \"$(cat /sys/class/power_supply/BAT0/capacity)%\"";
          color = "$foregrkund";
          font_size = 24;
          font_family = "JetBrains Mono";
          position = "-10, -10";
          halign = "right";
          valign = "top";
        };
      in [
        date
        time
        battery
      ];
    };
  };
}
