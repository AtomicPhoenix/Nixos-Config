{pkgs, ...}: {
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10; # Limit the number of generations to keep
      };
      efi.canTouchEfiVariables = true;
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
  };
}
