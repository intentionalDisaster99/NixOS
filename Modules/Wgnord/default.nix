{ config, pkgs, ... }:
{
  custom.services.nordvpn = {
    enable = true;
  };
  # environment.systemPackages = with pkgs; [
  #   wgnord
  #   openresolv
  #   wireguard-tools
  # ];
}
