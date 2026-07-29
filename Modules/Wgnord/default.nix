{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wgnord
    openresolv
    wireguard-tools
  ];
}
