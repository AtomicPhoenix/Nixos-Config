{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    baseIndex = 1;
    disableConfirmationPrompt = false;
    focusEvents = true;
    plugins = with pkgs; [
      tmuxPlugins.cpu
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # minutes
        '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-Right C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # removes the C-\ binding
        '';
      }
      {
        plugin = tmuxPlugins.tokyo-night-tmux;
        extraConfig = ''
          set -g @tokyo-night-tmux_theme storm    # storm | day | default to 'night'
          set -g @tokyo-night-tmux_transparent 1  # 1 or 0

          set -g @tokyo-night-tmux_window_id_style digital
          set -g @tokyo-night-tmux_pane_id_style hsquare
          set -g @tokyo-night-tmux_zoom_id_style dsquare

          # Icon styles
          set -g @tokyo-night-tmux_terminal_icon 
          set -g @tokyo-night-tmux_active_terminal_icon 

          # No extra spaces between icons
          set -g @tokyo-night-tmux_window_tidy_icons 0

          # To disable date time widget
          set -g @tokyo-night-tmux_show_datetime 0
          set -g @tokyo-night-tmux_date_format MYD
          set -g @tokyo-night-tmux_time_format 12H

          # Now playing
          set -g @tokyo-night-tmux_show_music 0

          # Net speed widget
          set -g @tokyo-night-tmux_show_netspeed 1
          set -g @tokyo-night-tmux_netspeed_iface "wlan0" # Detected via default route
          set -g @tokyo-night-tmux_netspeed_showip 0      # Display IPv4 address (default 0)
          set -g @tokyo-night-tmux_netspeed_refresh 1     # Update interval in seconds (default 1)

          # Path Widget
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'

          # Battery Widget
          set -g @tokyo-night-tmux_show_battery_widget 1
          set -g @tokyo-night-tmux_battery_name "BAT0"  # some linux distro have 'BAT0'
          set -g @tokyo-night-tmux_battery_low_threshold 21 # default
        '';
      }
      # tmuxPlugins.logging
    ];
    extraConfig = ''
      bind r source-file ~/.config/tmux/tmux.conf \; display "Configuration Reloaded!"

      # Split Panes
      bind \\ split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Fast Split Change
      setw -g mode-keys vi

      # Hook to run fastfetch on session creation
      set-hook -g after-new-session 'send-keys " clear && fastfetch" C-m'

      # Options to make tmux more pleasant
      set -g mouse on
      set -g default-terminal "tmux-256color"
    '';
  };
}
