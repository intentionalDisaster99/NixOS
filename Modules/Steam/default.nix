# Allows steam to be used for gaming 
{ config, pkgs, ... }:
{

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    steam
    steam-run
  ];
}
