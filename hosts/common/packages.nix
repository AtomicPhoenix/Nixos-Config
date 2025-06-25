{
  pkgs,
  inputs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    # Set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    rofi # Window switcher, run dialog, ssh-launcher and dmenu replacement

    # SSH protocol implementation
    openssh

    # File editor
    vim

    # File Browsers
    firefox
    chromium

    # Git/Github
    git # Git
    gh # Github

    spotify # Music
    obsidian # Notes
    clickup # Task Management
    discord # Social
    feh # Image viewer
    btop # Process Manager

    # Screenshots
    slurp
    grim

    # Notification System
    mako
    libnotify

    # Clipboard
    wl-clipboard

    # Terminal
    fastfetch
    tmux
    alacritty
    tree

    # Audio
    alsa-utils
    pavucontrol

    # Hyprland
    waybar
    hyprcursor
    hypridle
    hyprlock
    hyprpaper

    # Display Management
    nwg-displays
  ];
}
