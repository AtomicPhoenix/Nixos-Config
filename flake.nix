{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    hyprland.url = "github:hyprwm/Hyprland";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      # Inherits `inputs.nixpkgs` of current flake
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
	nixos = nixpkgs.lib.nixosSystem {
      	  specialArgs = { inherit inputs; }; # Let submodules access inputs
      	  system = "x86_64-linux";
      	  modules = [
      	    # Old configuration file
      	    ./configuration.nix

	    # Home-Manager; Deploys automatically on rebuild
  	    home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ai = import ./home.nix;

              # Can use home-manager.extraSpecialArgs to pass arguments to home.nix
            }
      	  ];
        };
     };
  };
}
