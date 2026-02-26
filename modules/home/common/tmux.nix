{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    prefix = "C-a";
    baseIndex = 1;
    mouse = true; # Enable mouse support
    keyMode = "vi"; # Use vi-style keybindings
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
    ];
    extraConfig = ''
      # Make C-a C-a send C-a to terminal
      bind C-a send-prefix

      # Hook to run fastfetch on session creation
      set-hook -g after-new-session 'send-keys -R "clear && fastfetch" C-m'

      # Ensure 256-color support
      set -g default-terminal "tmux-256color"

      # Automatically renumber windows
      set -g renumber-windows on
    '';
  };
}
