# See configuration.nix(5) man page and NixOS Manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  pkgs-unstable,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Define hostname.
  networking.hostName = "ai-duo";

  # Enable Bolt daemon for thunderbolt devices
  services.hardware.bolt.enable = true;

  # Optimizes battery life
  services.tlp.enable = true;

  hardware = {
    # Support IIO sensors with iio-sensor-proxy.
    # Accelerometer for laptop
    sensor.iio.enable = true;

    graphics = {
      enable = true;
      # Add packages to the default graphics driver lookup path.
      extraPackages = with pkgs; [
        vpl-gpu-rt
        mesa
        intel-media-driver
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };

  # Add matlab packages
  nixpkgs.overlays = [inputs.nix-matlab.overlay];

  environment.systemPackages = let
    get-kbd-connected = pkgs.writeShellApplication {
      name = "get-kbd-connected";
      text = builtins.readFile ./scripts/get-kbd-connected.sh;
    };
    toggle-monitor = pkgs.writeShellApplication {
      name = "toggle-monitor";
      text = builtins.readFile ./scripts/toggle-monitor.sh;
    };
    duo-manage-monitors = pkgs.writeShellApplication {
      name = "duo-manage-monitors";
      text = builtins.readFile ./scripts/duo-manage-monitors.sh;
    };
  in
    with pkgs; [
      matlab
      inotify-tools
      usbutils
      get-kbd-connected
      toggle-monitor
      duo-manage-monitors
      wireshark
      pkgs-unstable.ciscoPacketTracer9
    ];

  users.users.ai = {
    extraGroups = ["wireshark"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdhbEfOlA2Q4y1OHY4MdFOkcQpuZzJKaPxqFFsyngHM ai@ai-desk"
    ];
  };

  home-manager.users.ai = {
    programs = {
      ssh = let
        standard_config = hostname: {
          inherit hostname;
          identityFile = ["~/.ssh/ai-duo-personal"];
          port = 8102;
        };
      in {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            identityFile = ["~/.ssh/ai-duo-github"];
          };

          "ai-desk" = standard_config "ai-desk";

          # Cluster Nodes
          "master" = standard_config "master";
          "worker" = standard_config "worker";
          "worker-2" = standard_config "worker-2";
        };
      };

      ## Extend common bashrc located in ./common/bash.nix
      bash.bashrcExtra = lib.mkAfter ''
        ## Runs after rebuild command defined in ./common/bash.nix
        function post_rebuild()  {
          toggle-monitor
        }
      '';
    };

    wayland.windowManager.hyprland.settings.exec-once = ["duo-manage-monitors"];
  };

  # NixOS release to use (See man configuration.nix or https://nixos.org/nixos/options.html)
  # This value does not affect the Nixpkgs version your packages and OS are pulled from, so changing it will not upgrade your system.)
  # This value being lower than the current NixOS release does not mean your system is out of date, out of support, or vulnerable.
  system.stateVersion = "25.05";
}
