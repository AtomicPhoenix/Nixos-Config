{...}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./hardware.nix
    ./keyd.nix
    ./networking.nix
    ./nix-settings.nix
    ./openssh.nix
    ./packages.nix
    ./systemd.nix
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
  };
}
