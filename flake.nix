{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # Inherits `inputs.nixpkgs` of current flake
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Let submodules access inputs
        system = "x86_64-linux";
        modules = [
          # Old configuration file
          ./configuration.nix
          ./modules/nixos

          nvf.nixosModules.default
          # nvf.homeManagerModules.default # Imports home-manager module

          # Home-Manager; Deploys automatically on rebuild
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # home-manager.users.ai = import ./home.nix;
            home-manager.users.ai = import ./modules/home;

            home-manager.extraSpecialArgs = inputs;
            # Can use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
      };
    };
  };
}
