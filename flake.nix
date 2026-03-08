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

    # Silly bootloader teehee
    minegrub-world-sel-theme = {
      url = "github:Lxtharia/minegrub-world-sel-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # For running unpatched binaries
    nix-alien.url = "github:thiagokokada/nix-alien";

    # I'm dreaming of inventor on linux 🥰
    winboat = {
      url = "path:./modules/winboat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stenography perchance?
    plover-flake.url = "github:openstenoproject/plover-flake";

  };

  outputs = { self, nixpkgs, home-manager, minesddm, winboat, ... }@inputs: {


    # Laptop Configuration
    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/higgs-boson/configuration.nix
        inputs.minegrub-world-sel-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sa9m = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    # Desktop Configuration
    nixosConfigurations.gluon = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/gluon/configuration.nix
        home-manager.nixosModules.home-manager
        inputs.minegrub-world-sel-theme.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sa9m = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
        }
      ];

    };

  };




}


