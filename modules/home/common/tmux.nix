{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-s";
    baseIndex = 1;
    disableConfirmationPrompt = false;
    focusEvents = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        extraConfig = ''
          set -g @vim_navigator_mapping_left "C-Left C-h"  # use C-h and C-Left
          set -g @vim_navigator_mapping_right "C-Right C-l"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_prev ""  # Remove default C-\ binding
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

          # Date time widget
          set -g @tokyo-night-tmux_show_datetime 0

          # Now playing widget
          set -g @tokyo-night-tmux_show_music 0

          # Netspeed widget (requires package 'bc')
          set -g @tokyo-night-tmux_show_netspeed 0

          # Path widget
          set -g @tokyo-night-tmux_show_path 1
          set -g @tokyo-night-tmux_path_format relative # 'relative' or 'full'

          # Battery widget
          set -g @tokyo-night-tmux_show_battery_widget 0

          # Git widget
          set -g @tokyo-night-tmux_show_git 1

          # Web Based Git widget
          set -g @tokyo-night-tmux_show_wbg 1
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
