{pkgs, ...}: {
  home.packages = [pkgs.alacritty];

  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      window.opacity = 0.9;
      env.TERM = "xterm-256color";
      colors = {
        draw_bold_text_with_bright_colors = true;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        size = 12;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
