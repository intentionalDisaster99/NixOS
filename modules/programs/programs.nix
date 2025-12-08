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
  services.desktopManager.plasma6.enable = true;

  # Gaming
  programs.steam.enable = true;

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

  # Docker cause duh
  virtualisation.docker.enable = true;

  # Making sure I can use OBS
  programs.obs-studio = {
    enable = true;

    # optional Nvidia hardware acceleration
    # package = (
    #   pkgs.obs-studio.override {
    #     cudaSupport = true;
    #   }
    # );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # Telling ssh to work so that GitHub can
  programs.ssh.startAgent = false; # Gnome keyring covers this

  # Telling nixos it can use ventoy
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.07"
  ];

  # Switching to fish
  programs.fish.enable = true;

  # To connect to ma phone
  programs.kdeconnect = {
    enable = true;
  };

  # We love keyrings
  services.gnome.gnome-keyring.enable = true;
  # Unlock the Keychain automatically when you log in via SDDM
  security.pam.services.sddm.enableGnomeKeyring = true;

  # Allows nautilis to mount things
  services.gvfs.enable = true;


}
