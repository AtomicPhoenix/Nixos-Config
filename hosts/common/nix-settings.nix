_: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix = {
    # Perform garbage collection weekly to maintain low disk usage
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    # Remove nix-channel related tools & configs, we use flakes instead.
    channel.enable = false;

    settings = {
      # Optimizes storage by automatically finding store files with identical contents and replacing them with hard links to a single copy.
      auto-optimise-store = true;

      # Binary cache store for Hyprland
      # Exists to cache the hyprland packages and any dependencies not found in cache.nixos.org.
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      experimental-features = ["nix-command" "flakes"];
    };
  };
}
