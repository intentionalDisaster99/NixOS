{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.stremio
  ];

  networking.firewall = {
    allowedTCPPorts = [ 11470 ];
    allowedUDPPorts = [ 11470 ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
