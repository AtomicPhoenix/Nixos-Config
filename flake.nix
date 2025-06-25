{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Hyrland
    hyprland.url = "github:hyprwm/Hyprland";
    # Simple system to use Neovim configurations in Nix
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
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    getConfig = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Let submodules access inputs
        system = "x86_64-linux";
        modules = [
          # Device configuration file
          ./hosts/${hostname}
          # Global Modules
          ./modules/nixos

          nvf.nixosModules.default

          # Home-Manager; Deploys automatically on rebuild
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
      ai-desk = getConfig "ai-desk";
      ai-duo = getConfig "ai-duo";
    };
  };
}
