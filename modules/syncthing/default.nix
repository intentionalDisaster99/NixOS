{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "sa9m";
    # dataDir = "/home/sa9m"; 
    # configDir = "/home/sa9m/.config/syncthing";
  };
}