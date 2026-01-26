{ config, pkgs, lib, inputs, ... }:

{

  environment.systemPackages = with pkgs; [ openrgb-with-all-plugins ];

  # services.hardware.openrgb.enable = true;
  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };


}
