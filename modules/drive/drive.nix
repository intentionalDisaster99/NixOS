{ config, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.kdePackages.kaccounts-integration
    pkgs.kdePackages.kaccounts-providers
    pkgs.kdePackages.kio-gdrive
    pkgs.kdePackages.kio-fuse
    pkgs.qt6.qtwebengine
    pkgs.qt6.qtkeychain
  ];

  # services.kio-fuse.enable = true;
  services.gvfs.enable = true;


}
