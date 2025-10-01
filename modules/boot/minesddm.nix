# /etc/nixos/flake.nix

{
  description = "Main NixOS Configuration Entrypoint";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # 1. Add the theme flake as a new input
    minesddm = {
      url = "github:keyitdev/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 2. Add 'minesddm' to the function arguments
  outputs = { self, nixpkgs, home-manager, minesddm, ... }@inputs: {
    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Main config
        ./main/configuration.nix

        # 3. Import the module directly from the flake input
        minesddm.nixosModules.default

        # Home manager
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
