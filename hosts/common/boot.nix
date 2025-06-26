{pkgs, ...}: {
  # Bootloader.
  boot = {
    initrd.preDeviceCommands = ''
      ${pkgs.fortune} | ${pkgs.neo-cowsay} --bold --aurora -f tux
    '';

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
