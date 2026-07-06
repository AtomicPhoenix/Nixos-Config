{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

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
      url = "github:nix-community/home-manager/release-26.05";
      # Inherits `inputs.nixpkgs` of current flake
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix flake for the Eden Nintendo Switch emulator.
    eden = {
      url = "github:Daaboulex/eden-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nvf,
    sops-nix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    mkNixosConfiguration = hostname:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs pkgs-unstable;}; # Let submodules access inputs and pkgs-unstable
        inherit system;

        modules = [
          # Device configuration file
          ./hosts/${hostname}

          # NixOS Modules
          nvf.nixosModules.default
          sops-nix.nixosModules.sops
          inputs.eden.nixosModules.default

          # NIXOS Modules Configuration
          ./modules/nixos

          # Home-Manager Module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true; # Use nixos's pkgs value
              extraSpecialArgs = {inherit inputs pkgs-unstable;}; # Pass arguments to home modules
              users.ai.imports = [./modules/home];
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
