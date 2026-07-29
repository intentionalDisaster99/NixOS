# May or may not work, tbh idk
{ config
, pkgs
, lib
, ...
}:
{
  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
    pkgs.platformio-core.udev
  ];
  programs.nix-ld.enable = true;
}
