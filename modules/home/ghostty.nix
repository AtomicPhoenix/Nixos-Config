{...}: {
  programs.ghostty = {
    enable = true;

    settings = {
      background-opacity = 0.9;
      window-padding-x = 4;
      window-padding-y = 2;
      term = "xterm-256color";
      font-family = "FiraCode Nerd Font Mono";
      font-size = 12;
      copy-on-select = true;
    };
  };
}
