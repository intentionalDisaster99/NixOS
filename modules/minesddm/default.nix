# {
#   description = "A minecraft themed sddm";

#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

#     # Minesddm
#     minesddm = {
#       url = "github:Davi-S/sddm-theme-minesddm";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#     # # Home manager
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#   };

#   outputs = { self, nixpkgs, minesddm, ... }:
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#     in
#     {
#       nixosConfigurations.higgs-boson = nixpkgs.lib.nixosSystem {
#         inherit system;
#         # specialArgs = {inherit inputs;};
#         modules = [
#           ./configuration.nix

#           # Home manager
#         #   inputs.home-manager.nixosModules.default


#           # Minesddm
#           ({ pkgs, ... }: {
#             environment.systemPackages = [ minesddm.packages.${system}.default ];

#             services.displayManager.sddm.theme = "minesddm";
#           })



#         ];
#       };
#     };
# }
# configuration.nix

{ config, pkgs, ... }:

let
  # If your flake defines a default package
  minesddmPkg = pkgs.callPackage ./path-to-minesddm-package.nix {};
in
{
  services.displayManager.sddm = {
    enable = true;
    theme = "minesddm";
  };

  environment.systemPackages = [ minesddmPkg ];
}
