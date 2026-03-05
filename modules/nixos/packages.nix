{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  services.tailscale.enable = true;

  environment.systemPackages = let
    import_env = pkgs.writeShellApplication {
      name = "import_env";
      text = builtins.readFile ./scripts/import_env.sh;
    };
    load_tmux = (pkgs.writeScriptBin "load_tmux" ./scripts/load_tmux.sh).overrideAttrs (old: {
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
      import_env
      load_tmux
      set-brightness

      # VPN
      protonvpn-gui

      # Games
      lutris
      vulkan-tools
      cemu
      dolphin-emu

      # SSH protocol implementation
      openssh

      # File Management
      vim
      unzip

      # Git/Github
      git
      gh

      # Required for tmux web based git plugin
      jq
      bc

      # Misc. Apps
      spotify
      obsidian
      clickup
      discord

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
      feh
      btop

      # Audio
      alsa-utils
      pavucontrol

      # Temperature Sensor
      lm_sensors # Hyprland
      hyprcursor

      # Music Production
      reaper
      alsa-scarlett-gui

      # Office Suite
      libreoffice

      # XDG
      xdg-utils
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
