_: {
  wayland.windowManager.hyprland = {
    # Enable Hyprland wayland compositor
    enable = true;

    # Whether to enable XWayland
    xwayland.enable = true;

    # Enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    settings = {
      monitor = [
        "eDP-1, 2880x1800@120.0Hz, 0x0, 2"
        "eDP-2, 2880x1800@120.0Hz, 0x900, 2"
      ];

      # Sets "Windows" key as main modifier
      "$mainMod" = "SUPER";

      exec-once = [
        "mako &"
        "waybar"
        "hyprpaper"
        "hypridle"
        "clickup"
        "discord"
        "sudo btmgmt le on"
        "systemctl --user start hyprpolkitagent"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 4;

        border_size = 1;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = "rgb(1793d0)";
        "col.inactive_border" = "rgb(000000)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 4;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        #drop_shadow = true
        #shadow_range = 4
        #shadow_render_power = 3
        #col.shadow = rgba(1a1a1aee)
        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true;

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background
        disable_splash_rendering = true; # Disable default wallpaper & splash text
      };

      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input = {
        kb_layout = "us";
        # kb_variant =
        # kb_model =
        # kb_options =
        # kb_rules =

        follow_mouse = 1;

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = false;
        };
      };

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      ####################
      ### KEYBINDINGSS ###
      ####################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      "$useWayland" = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
      ## Icons
      "$spotifyIcon" = "~/Pictures/Icons/spotify.png";
      "$discordIcon" = "~/Pictures/Icons/discord.png";
      "$clickUpIcon" = "~/Pictures/Icons/clickup.png";
      "$obsidianIcon" = "~/Pictures/Icons/obsidian.png";

      bind = [
        # Window Dispatchers
        "$mainMod, P, pseudo," # Toggle dwindle's psuedotile mode
        "$mainMod, Q, killactive," # Kill active window
        "$mainMod, V, togglefloating," # Toggle floating window mode

        # Application Shortcuts
        "$mainMod,       RETURN, exec, alacritty -e load_tmux"
        "$mainMod SHIFT, RETURN, exec, alacritty"
        "$mainMod, M, exec, hyprlock" # Lock Screen
        "$mainMod, F, exec, firefox"
        "$mainMod, D, exec, rofi -show || (pkill rofi && rofi -show)" # Open Rofi Menu

        "$mainMod CTRL, S, exec, (hyprctl dispatch focuswindow class:spotify  | grep ok)  || (notify-send -i $spotifyIcon  'Starting Spotify'  && spotify  $useWayland)"
        "$mainMod CTRL, D, exec, (hyprctl dispatch focuswindow class:discord  | grep ok)  || (notify-send -i $discordIcon  'Starting Discord'  && discord  $useWayland)"
        "$mainMod CTRL, C, exec, (hyprctl dispatch focuswindow class:ClickUp  | grep ok)  || (notify-send -i $clickUpIcon  'Starting Clickup'  && clickup  $useWayland)"
        "$mainMod CTRL, O, exec, (hyprctl dispatch focuswindow class:obsidian | grep ok)  || (notify-send -i $obsidianIcon 'Starting Obsidian' && obsidian $useWayland)"

        # Screenshots
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp -d -w 0)\" - | wl-copy; notify-send 'Image copied to clipboard'"
        "$mainMod ALT, S, exec, grim -g \"$(slurp -d -w 0)\"; notify-send 'Image saved to ~/Pictures/'"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move focus with mainMod + letter keys
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        # Switch between extend and duplicate displays
        "$mainMod SHIFT, M, exec, /usr/local/bin/swapMonitorMode.sh"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, code:49, workspace, previous"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Switch workspaces with mainMod + arrow keys
        "$mainMod, left, workspace, (hyprctl activeworkspace -j | jq '.id')-1"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Fullscreen
        "$mainMod SHIFT, F, fullscreen, 0"
        "$mainMod SHIFT, P, pin, 0"
        "$mainMod SHIFT, P, exec, notify-send 'Window pinned'"

        # Toggle Waybar
        "$mainMod SHIFT, B, exec,  pkill waybar || waybar"
      ];

      # Repating Binds that will also work in a lock screen
      bindel = [
        # Audio Settings
        ", XF86AudioMute, exec, amixer set Master toggle"
        ", XF86AudioLowerVolume, exec, amixer set Master 5%-"
        ", XF86AudioRaiseVolume, exec, amixer set Master 5%+"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        ", F1, exec, amixer set Master toggle"
        ", F2, exec, amixer set Master 5%-"
        ", F3, exec, amixer set Master 5%+"
        ", F7, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # Brightness Settings
        ", F5, exec, set-brightness 5%-"
        ", F6, exec, set-brightness 5%+"
      ];

      # Repeating Binds
      binde = [
        # Switch workspace with mainMod + arrow keys
        "$mainMod ALT, left, workspace, -1"
        "$mainMod ALT, right, workspace, +1"
        "$mainMod ALT, p, workspace, previous"

        # Resize windows with mainMod + shift + arrow keys
        "$mainMod SHIFT, left, resizeactive,  -40  0"
        "$mainMod SHIFT, right, resizeactive,  40 0"
        "$mainMod SHIFT, down, resizeactive,  0  40"
        "$mainMod SHIFT, up, resizeactive,  0  -40"

        # Move Windows with mainMod + ctrl + arrow keys
        "$mainMod CTRL, left, movewindow, l"
        "$mainMod CTRL, right, movewindow, r"
        "$mainMod CTRL, down, movewindow, d"
        "$mainMod CTRL, up, movewindow, u "

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

        # Raise/lower windows with mouse side buttons
        ", mouse:276, exec, amixer set Master 5%+"
        ", mouse:275, exec, amixer set Master 5%-"
      ];

      # Mouse binds
      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = import ./windowrules.nix;
    };
  };
}
