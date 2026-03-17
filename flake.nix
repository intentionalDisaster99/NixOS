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

    # For managing KDE
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # For running unpatched binaries
    nix-alien.url = "github:thiagokokada/nix-alien";

    # For secrets management
    sops-nix.url = "github:Mic92/sops-nix";

    # I'm dreaming of inventor on linux 🥰
    winboat = {
      url = "path:./modules/winboat";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Stenography perchance?
    plover-flake.url = "github:openstenoproject/plover-flake";

    # For better hyprland experience on my pc
    hyprsplit.url = "github:shezdy/hyprsplit";

  };

  outputs = { self, nixpkgs, home-manager, minesddm, winboat, sops-nix, plasma-manager, ... }@inputs: {


    # Laptop Configuration
    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/higgs-boson/configuration.nix
        sops-nix.nixosModules.sops
        inputs.minegrub-world-sel-theme.nixosModules.default
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sa9m = { ... }: {
            imports = [
              ./home.nix
              ./modules/kde/home-kde.nix
            ];
          };
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
        sops-nix.nixosModules.sops
        home-manager.nixosModules.home-manager
        inputs.minegrub-world-sel-theme.nixosModules.default
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sa9m = { ... }: {
            imports = [
              ./home.nix
              ./modules/kde/home-kde.nix
            ];
          };
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
        }
      ];

    };

  };




}


