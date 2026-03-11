{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.nix-alien.packages.${stdenv.hostPlatform.system}.nix-alien
  ];

  programs.nix-ld.enable = true;
}
