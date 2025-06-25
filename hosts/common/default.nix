{...}: {
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./nix-settings.nix
    ./packages.nix
    ./services.nix
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
      extraGroups = ["networkmanager" "wheel"];
      # packages = with pkgs; [];
    };
    # guest = {
    #   isNormalUser = true;
    #   description = "Guest user";
    # };
  };
}
