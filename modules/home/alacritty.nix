{
  pkgs, ...
}: {
  home.packages = [pkgs.alacritty];

  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      colors = {
        draw_bold_text_with_bright_colors = true;
      };
      font = {
        size = 12;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}

