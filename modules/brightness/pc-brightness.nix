# This module is for enabling system-wide programs and services.
{ config, pkgs, lib, ... }:

{

  # Making sure that we have access to the thing that controls the brightness
  environment.systemPackages = with pkgs; [
    ddcutil
  ];

  # Everything else depends on hyprland


}
