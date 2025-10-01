{

  description = "Main NixOS Configuration Entrypoint";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Silly sddm teehee
    minesddm = {
      url = "github:Davi-S/sddm-theme-minesddm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, minesddm, ... }@inputs: {

    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {

      system = "x86_64-linux";

      specialArgs = { inherit inputs; };

      minesddm.nixosModules.default

        modules = [
        # Main config
        ./main/configuration.nix

        # Home manager (we love these useful comments)
        home-manager.nixosModules.home-manager
      ];

    };
  };




}


