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

  environment.systemPackages = with pkgs; [
    (builtins.getFlake "github:astrada/google-drive-ocamlfuse").packages.x86_64-linux.default
  ];

  outputs = { self, nixpkgs, home-manager, minesddm, winboat, ... }@inputs: {


    # Laptop Configuration
    nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./hosts/higgs-boson/configuration.nix
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


