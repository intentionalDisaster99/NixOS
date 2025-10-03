{ config, pkgs, ... }:

{
  environment.systemPackages = [
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kio-gdrive
  ];

  services.kio-fuse.enable = true;
  services.gvfs.enable = true;


}
