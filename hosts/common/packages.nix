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

  environment.systemPackages = let
    load_tmux = (pkgs.writeScriptBin "load_tmux" ./scripts/load_tmux.sh).overrideAttrs (old: {
      buildCommand = "${old.buildCommand}\n patchShebangs $out";
    });
    randomize_wallpaper = (pkgs.writeShellScriptBin "randomize_wallpaper" ./scripts/randomize_wallpaper.sh).overrideAttrs (old: {
      buildCommand = "${old.buildCommand}\n patchShebangs $out";
    });
  in
    with pkgs; [
      # Self-defined packages
      load_tmux
      randomize_wallpaper

      # VPN
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

      # Temperature Sensor
      lm_sensors

      # Hyprland
      hyprcursor

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
