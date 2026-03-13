# /etc/nixos/programs.nix
{ config, pkgs, lib, ... }:

{
  # Import the more specific modules from the programs/ directory
  imports = [
    ./packages.nix
    ./aliases.nix
  ];

  ###########################
  # Enabling all the things #
  ###########################

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

  hardware.enableAllFirmware = true;

  # Docker cause duh
  virtualisation.docker.enable = true;

  # Making sure I can use OBS
  programs.obs-studio = {
    enable = true;

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
  programs.dconf.enable = true;

  # Allows nautilis to mount things
  services.gvfs.enable = true;
  services.sysprof.enable = true;
  services.udisks2.enable = true;

  # TODO move this to a module so that I can exclude it from my PC
  # Power management
  powerManagement.enable = true;
  services.power-profiles-daemon.enable = lib.mkForce false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      #  START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
      #  STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };

  # Being able to SSH into my machines
  services.openssh.enable = true;

  # Turning NordVPN on
  services.wgnord = {
    enable = true;
    country = "United States"; # Change whenever you want
    # Point this to wherever you keep your secret
    tokenFile = "/home/sa9m/.confidential/wgnordToken.txt";
  };


  # TODO create a pay-respects module
  programs.pay-respects.enable = true;
  programs.nix-index.enable = true;

}
