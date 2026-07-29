# Should be a thing to stream shows and moveis, but idk, it hasn't worked for me before
{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    stremio-linux-shell
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
