{ config, pkgs, ... }:

{
  environment.systemPackages = [
    # pkgs.kdePackages.kaccounts-integration
    # pkgs.kdePackages.kaccounts-providers
    # pkgs.kdePackages.kio-gdrive
    # pkgs.kdePackages.kio-fuse
    pkgs.plasma6Packages.kaccounts-integration
    pkgs.plasma6Packages.kaccounts-providers
    pkgs.plasma6Packages.kio-gdrive
    pkgs.plasma6Packages.kio-fuse
  ];

  # services.kio-fuse.enable = true;
  services.gvfs.enable = true;


}
