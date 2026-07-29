{ config, pkgs, ... }:
{
  imports = [
    inputs.nordvpn-nix.nixosModules.default
  ];
  custom.services.nordvpn = {
    enable = true;
  };
  # environment.systemPackages = with pkgs; [
  #   wgnord
  #   openresolv
  #   wireguard-tools
  # ];
}
