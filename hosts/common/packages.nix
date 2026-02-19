{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs = {
    hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      # Sync portal package with hyprland package
      portalPackage = pkgs-unstable.xdg-desktop-portal-hyprland;
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
    unzip = (pkgs.writeShellScriptBin "unzip" ./scripts/unzip.sh).overrideAttrs (old: {
      buildCommand = "${old.buildCommand}\n patchShebangs $out";
    });
    set-brightness = pkgs.writeShellApplication {
      name = "set-brightness";
      runtimeInputs = with pkgs; [
        brightnessctl
      ];
      text = builtins.readFile ./scripts/set-brightness.sh;
    };
  in
    with pkgs; [
      # Self-defined packages
      load_tmux
      randomize_wallpaper
      unzip
      set-brightness

      # VPN
      protonvpn-gui

      # Emulators
      cemu
      dolphin-emu

      # SSH protocol implementation
      openssh

      # File editor
      vim

      direnv # direnv

      # File Browsers
      # firefox

      # Git
      git # Git
      gh # Github
      jq # Required for tmux web based git plugin
      bc # Required for tmux web based git plugin

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

      # Office Suite
      libreoffice
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
