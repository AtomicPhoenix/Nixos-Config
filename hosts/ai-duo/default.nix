# See configuration.nix(5) man page and NixOS Manual (accessible by running ‘nixos-help’).
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include common configuration
    ../common
  ];

  # Define hostname.
  networking.hostName = "ai-duo";

  # Enable Bolt daemon for thunderbolt devices
  services.hardware.bolt.enable = true;

  hardware = {
    # Support IIO sensors with iio-sensor-proxy.
    # Accelerometer for laptop
    sensor.iio.enable = true;

    graphics = {
      # Add packages to the default graphics driver lookup path.
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    inotify-tools
    usbutils
  ];

  users.users.ai.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGdhbEfOlA2Q4y1OHY4MdFOkcQpuZzJKaPxqFFsyngHM ai@ai-desk"
  ];

  # NixOS release to use (See man configuration.nix or https://nixos.org/nixos/options.html)
  # This value does not affect the Nixpkgs version your packages and OS are pulled from, so changing it will not upgrade your system.)
  # This value being lower than the current NixOS release does not mean your system is out of date, out of support, or vulnerable.
  system.stateVersion = "25.05";
}
