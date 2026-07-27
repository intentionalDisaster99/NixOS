# Syncthing in general to be used (you'll still have to set it up yourself, go to localhost:8384)
# Make sure to update sa9m to your username if you use it
{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "sa9m";
    dataDir = "/home/sa9m"; # default location for new folders
    configDir = "/home/sa9m/.config/syncthing";
  };
}
