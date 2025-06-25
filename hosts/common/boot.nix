{pkgs, ...}: {
  # Bootloader.
  boot = {
    initrd.preDeviceCommands = ''
      ${pkgs.fortune} | ${pkgs.neo-cowsay} --bold --aurora -f tux
    '';

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10; # Limit the number of generations to keep
    };

    # Use latest kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = ["ntfs"];
  };
}
