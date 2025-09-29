{

    description = "Main NixOS Configuration Entrypoint";

    inputs = {

        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

    };

    outputs = {self, nixpkgs, home-manager, ...}@inputs: {

        nixosConfigurations.higgs-boson = {

            system = "x86_64-linux";

            modules = [
                # Main config
                ./configuration.nix

                # Home manager (we love these useful comments)
                home-manager.nixosModules.home-manager
            ];

        }
    };




}


