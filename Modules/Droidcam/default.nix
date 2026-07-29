# A nice program that allows you to use your phone as a webcam
{ config, lib, pkgs, ... }: {
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="DroidCam"
  '';
  programs.droidcam.enable = true;
}
