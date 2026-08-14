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
    pkgs.teensy-loader-cli
    pkgs.platformio
    pkgs.teensy-udev-rules
    pkgs.platformio-core
  ];
  programs.nix-ld.enable = true;
}
