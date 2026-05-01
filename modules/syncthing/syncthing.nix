{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "sa9m";
    dataDir = "/home/sa9m"; # default location for new folders
    configDir = "/home/sa9m/.config/syncthing";
  };
}
