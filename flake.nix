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

    # I'm dreaming of inventor on linux 🥰
    winboat = {
      url = "path:./modules/winboat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, minesddm, winboat, ... }@inputs: {

    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {

      system = "x86_64-linux";


      specialArgs = { inherit inputs; };


      modules = [
        # Main config
        ./main/configuration.nix

        # minesddm.nixosModules.default
        home-manager.nixosModules.home-manager

        # Home manager (we love these useful comments)
        home-manager.nixosModules.home-manager
      ];

    };
  };




}


