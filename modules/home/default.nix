{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./git.nix
    ./alacritty.nix
    ./bash.nix
    ./nix-direnv.nix
    ./firefox.nix
    ./tmux.nix
    ./mpv.nix
    ./proton.nix
    ./hyprland.nix
    ./wayland.nix
    # ./nvf.nix
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
