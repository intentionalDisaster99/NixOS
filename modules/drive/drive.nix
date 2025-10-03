{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.plasma6Packages.kaccounts-integration
    pkgs.plasma6Packages.kaccounts-providers
    pkgs.plasma6Packages.kio-gdrive
    pkgs.plasma6Packages.kio-fuse
  ];

  # services.kio-fuse.enable = true;
  services.gvfs.enable = true;


}
