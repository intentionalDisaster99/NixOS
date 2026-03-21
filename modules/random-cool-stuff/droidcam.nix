{ config, lib, pkgs, ... }:

{
  # Not needed because the `programs.droidcam.enable` installs it for me 
  # environment.systemPackages = [
  #   pkgs.droidcam
  # ];

  programs.droidcam.enable = true;
  # boot.extraModulePackages = with config.boot.kernelPackages; [ 
  #   v4l2loopback 
  # ];
  #
  # boot.kernelModules = [ 
  #   "v4l2loopback" 
  # ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="DroidCam"
  '';

}
