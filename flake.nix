{

  description = "My rewritten NixOS config entrypoint :D";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-latest.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

  };


  outputs = { self, nixpkgs, nixpkgs-latest, nur, home-manager, ... }@inputs:

    let
      # This is where all of my global variables go 
      username = "sa9m";
    in
    {

      # Laptop
      nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs username;
        };
        system = "x86_64-linux";
        modules = [
          ./Hosts/Higgs-boson/configuration.nix
          ./Modules/cachix.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # TODO remove this; it is now not needed as I declare home manager stuff in each file
            # home-manager.users.sa9m = import ./Users/Sa9m/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs username;
            };
          }
        ];
      };

      # Desktop
      nixosConfigurations.gluon = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        system = "x86_64-linux";
        modules = [
          ./Hosts/Gluon/configuration.nix
          ./Modules/cachix.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # TODO remove this; it is now not needed as I declare home manager stuff in each file
            # home-manager.users.sa9m = import ./Users/Sa9m/home.nix;
            home-manager.extraSpecialArgs = {
              inherit inputs username;
            };
          }
        ];
      };
    };

}





