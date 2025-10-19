{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      # Set the flake package
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    gamemode.enable = true;
  };

  services.tailscale.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    # let
    # Rotate through wallpapers
    # wallpaper_autoplay = (pkgs.writeScriptBin "wallpaper_autoplay" ./scripts/wallpaper_autoplay.sh).overrideAttrs (old: {
    #   buildCommand = "${old.buildCommand}\n patchShebangs $out";
    # });
    # in
    with pkgs; [
      # wallpaper_autoplay
      protonvpn-gui

      # SSH protocol implementation
      openssh

      # File editor
      vim

      direnv # direnv

      # File Browsers
      # firefox

      # Git/Github
      git # Git
      gh # Github

      spotify # Music
      obsidian # Notes
      clickup # Task Management
      discord # Social
      feh # Image viewer
      btop # Process Manager

      # Games
      lutris
      vulkan-tools
      cemu

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
      hyprlock
      # hypridle
      hyprpaper

      # Display Management
      nwg-displays

      # Music Production
      reaper
      alsa-scarlett-gui
    ];

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
    };
  };
}
