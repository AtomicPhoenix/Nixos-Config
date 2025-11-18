{lib, ...}: {
  imports = [
    ./alacritty.nix
    ./bash.nix
    ./firefox.nix
    ./git.nix
    ./hypr
    ./mpv.nix
    ./nix-direnv.nix
    ./proton.nix
    ./rofi.nix
    ./tmux.nix
    ./waybar/waybar.nix
    ./wayland.nix
  ];

  /**
  Default Applications
  */
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  home = {
    username = "ai";
    homeDirectory = lib.mkForce "/home/ai";
    stateVersion = "25.05";
  };
}
