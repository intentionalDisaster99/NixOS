{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.droidcam
  ];

  programs.droidcam.enable = true;
  # boot.extraModulePackages = with config.boot.kernelPackages; [ 
  #   v4l2loopback 
  # ];
  #
  # boot.kernelModules = [ 
  #   "v4l2loopback" 
  # ];
}
