# Controls the bootloader that I use (Grub)

{ config, pkgs, lib, inputs, ... }:

{

  environment.systemPackages = with pkgs; [ openrgb-with-all-plugins ];

  services.hardware.openrgb.enable = true;

}
