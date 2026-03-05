{...}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./fonts.nix
    ./hardware.nix
    ./keyd.nix
    ./networking.nix
    ./nix-settings.nix
    ./neovim
    ./openssh.nix
    ./packages.nix
    ./terminal.nix
    ./time-and-locale.nix
  ];

  # Defines the user account.
  users.users = {
    ai = {
      home = "/home/ai";
      isNormalUser = true;
      description = "ai";
      extraGroups = ["networkmanager" "wheel" "docker"];
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
}
