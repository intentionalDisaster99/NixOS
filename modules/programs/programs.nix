# /etc/nixos/programs.nix
{ config, pkgs, lib, ... }:

{
  # Import the more specific modules from the programs/ directory
  imports = [
    ./packages.nix
    ./aliases.nix
  ];

  ##########################
  # Enabling all the things#
  ##########################

  # I need to be able to see things
  services.xserver.enable = true;
  # services.desktopManager.plasma6.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Gaming
  programs.steam.enable = true;

  # SDDM to switch between environments
  services.displayManager.sddm.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  # My shell environment
  # users.defaultUserShell = pkgs.zsh;


}
