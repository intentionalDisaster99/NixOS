# This is just what I had when I got PIO to work. Still don't quite know if this is what is needed or if something else did it

{ config, pkgs, lib, ... }:

{
  services.udev.packages = [
    pkgs.platformio-core
    pkgs.openocd
    pkgs.platformio-core.udev
  ];
  programs.nix-ld.enable = true;

}
