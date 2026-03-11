{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.nix-alien.packages.${pkgs.stdenv.hostPlatform.system}.nix-alien
  ];

  programs.nix-ld.enable = true;
}
