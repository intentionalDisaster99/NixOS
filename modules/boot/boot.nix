# Controls the bootloader that I use (Grub)

{ config, pkgs, lib, inputs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  # Takes absolute ages so commented for now 
  # TODO Add in extra boot entries per host
  boot.loader.grub.useOSProber = true;

  # Teehee silly sddm
  services.displayManager.sddm = {
    enable = true;
    theme = "minesddm";
    wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Add the theme package itself
    inputs.minesddm.packages.${pkgs.system}.default

    # Add the required Qt dependencies
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];

}
