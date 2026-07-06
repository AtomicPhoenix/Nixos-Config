{
  pkgs,
  lib,
  inputs,
  ...
}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };

  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.tailscale.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libkrb5
    krb5
    nspr
    nss
    glib
    mesa

    zlib
    stdenv.cc.cc

    # X11
    libX11
    libXcursor
    libXi
    libXinerama
    libXrandr
    libXrender
    libXext
    libXfixes
    libXcomposite
    libXdamage
    libXxf86vm
    libxcb

    # Input/keyboard
    libxkbcommon

    # Graphics
    libGL
    libdrm

    # GTK deps
    atk
    at-spi2-atk
    cairo
    pango
    gtk3
    dbus
    expat
    cups
  ];

  environment.systemPackages = let
    import_env = pkgs.writeShellApplication {
      name = "import_env";
      text = builtins.readFile ./scripts/import_env.sh;
    };
    load_tmux = pkgs.writeShellApplication {
      name = "load_tmux";
      text = builtins.readFile ./scripts/load_tmux.sh;
    };
    set-brightness = pkgs.writeShellApplication {
      name = "set-brightness";
      runtimeInputs = with pkgs; [
        brightnessctl
      ];
      text = builtins.readFile ./scripts/set-brightness.sh;
    };
    update = pkgs.writeShellApplication {
      name = "update";
      text = builtins.readFile ./scripts/update.sh;
    };
    rebuild = pkgs.writeShellApplication {
      name = "rebuild";
      text = builtins.readFile ./scripts/rebuild.sh;
    };
  in
    with pkgs; [
      # Self-defined packages
      import_env
      load_tmux
      set-brightness
      update
      rebuild

      # VPN
      proton-vpn

      # Games
      # lutris
      appimage-run
      vulkan-tools
      cemu
      dolphin-emu
      protonup-ng

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
      # clickup
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

      # File Manager for GDK Apps
      zenity

      qbittorrent
      gamescope

      (mpv.override {
        scripts = [
          mpvScripts.uosc
          mpvScripts.sponsorblock
        ];
      })
    ];

  nixpkgs.overlays = [
    inputs.eden.overlays.default
  ];

  programs.eden = {
    enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs = pkgs:
        with pkgs; [
          libXcursor
          libXi
          libXinerama
          libXScrnSaver
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
