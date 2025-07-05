{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # sops-nix: Secret provisioning for NixOS based on sops
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyrland
    hyprland.url = "github:hyprwm/Hyprland";

    # Neovim configuration system for Nix
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home-Manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs"; # Inherits `inputs.nixpkgs` of current flake
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    sops-nix,
    ...
  } @ inputs: let
    mkNixosConfiguration = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Let submodules access inputs
        system = "x86_64-linux";
        modules = [
          # Device configuration file
          ./hosts/${hostname}
          # Global Modules
          ./modules/nixos

          nvf.nixosModules.default
          sops-nix.nixosModules.sops

          # Home-Manager deploys automatically on rebuild
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ai = import ./modules/home;
              extraSpecialArgs = inputs;
              # Can use extraSpecialArgs to pass arguments to home.nix
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      ai-desk = mkNixosConfiguration "ai-desk";
      ai-duo = mkNixosConfiguration "ai-duo";
    };
  };
}
