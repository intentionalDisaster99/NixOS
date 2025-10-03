{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kdePackages.kaccounts-integration
    pkgs.kdePackages.kaccounts-providers
    pkgs.kdePackages.kio-gdrive
  ];

  services.kio-fuse.enable = true;
  services.gvfs.enable = true;


}
