{ config, pkgs, ... }:

let
  stremio-wrapped = pkgs.writeShellScriptBin "stremio" ''
    exec ${pkgs.stremio-linux-shell}/bin/stremio-linux-shell --no-sandbox "$@"
  '';

  stremio-desktop = pkgs.makeDesktopItem {
    name = "stremio";
    desktopName = "Stremio";
    exec = "${stremio-wrapped}/bin/stremio";
    icon = "stremio";
    comment = "Watch videos, movies, and TV shows easily";
    categories = [ "Video" "AudioVideo" "Player" "TV" ];
  };
in
{
  environment.systemPackages = [
    stremio-wrapped
    stremio-desktop
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
