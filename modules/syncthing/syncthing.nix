# I think this works but I'm not sure (I haven't tested in a while lol)

{ config, pkgs, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "sa9m";
    dataDir = "/home/sa9m"; # default location for new folders
    configDir = "/home/sa9m/.config/syncthing";
  };
}
