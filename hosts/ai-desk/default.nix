# See configuration.nix(5) man page and NixOS Manual (accessible by running ‘nixos-help’).
{lib, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include common configuration
    ../common
  ];

  # Define hostname.
  networking.hostName = "ai-desk";

  boot.loader = lib.mkForce {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # default /boot
    };
    systemd-boot = {
      # enable = true; # enabled in ../common/boot.nix
      configurationLimit = 5;
      consoleMode = "max";
      windows = {
        "nvme1n1p1" = {
          title = "Windows 11";
          # sudo blkid //check Windows ESP PARTUUID
          # reboot to systemd-boot uefi shell and type: map
          # find the FS alias match Windows ESP (ex: HD0a66666a2, HD0b, FS1, or BLK7)
          efiDeviceHandle = "FS0";
          sortKey = "a_windows";
        };
      };
    };
  };

  users.users.ai.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHMD7R3C50biFqJaBhIXYQZNCKtsM/e35Oh7b1h6ESSX ai@ai-duo"
  ];

  # NixOS release to use (See man configuration.nix or https://nixos.org/nixos/options.html)
  # This value does not affect the Nixpkgs version your packages and OS are pulled from, so changing it will not upgrade your system.)
  # This value being lower than the current NixOS release does not mean your system is out of date, out of support, or vulnerable.
  system.stateVersion = "25.05";
}
