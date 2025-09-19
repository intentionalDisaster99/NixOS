# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{


  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "sa9m" = import ./home.nix;
    };
  };

  # programs.hyprland.enable = true;
  # programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;

  # Bootloader
  boot.loader.systemd-boot.enable =  false;
  boot.loader.efi.canTouchEfiVariables = true; 
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";  
  boot.loader.grub.extraEntries = ''
    menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-7282-E320' {
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 7282-E320
	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
   }
   
   menuentry 'Arch Linux (on /dev/nvme0n1p6)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-edc2422e-b5ee-48f7-a0e7-b17f7b05e9d0' {
	insmod part_gpt
	insmod fat
	search --no-floppy --fs-uuid --set=root 7282-E320
	linux //kernels/0494yc5krhmsrp4vcrlbp1r5fnx6cflf-linux-6.12.44-bzImage init=/nix/store/iswxw6pn34jfmmfh9yc04y7wzi7cdzfn-nixos-system-higgs-boson-25.11.20250830.d7600c7/init loglevel=4 lsm=landlock,yama,bpf
	initrd //kernels/bww4s0s751r2xlmhlin5zzisj5ahqrkm-initrd-linux-6.12.44-initrd
   }

  ''; 
  boot.loader.grub.useOSProber = true;

  networking.hostName = "higgs-boson"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
 
 
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  
  # Setting up bluetooth
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  programs.kdeconnect.enable = true;   

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sa9m = {
    isNormalUser = true;
    description = "Sam Whitlock";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

     # OS Essentials
     grub2
     os-prober
     git
     github-desktop
     libinput
     zoxide
     fastfetch
     libnotify
     tesseract4
     gImageReader
     zoom-us
     eyedropper
     syncthing
     hyprland

     # Coding
     vim
     vscode
     kdePackages.yakuake 
     arduino-ide
     python314

     # General
     brave
     spotify
     obsidian
     discord

     # Networking
     geteduroam    
     tailscale

     # Gaming
     prismlauncher

  ];

  programs.bash.shellAliases = {
    cd="z";  
    nrs="sudo nixos-rebuild switch";
    windows = "sudo grub-reboot 2 && reboot";
  };
   


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.zoxide.enable = true;
  services.libinput.enable = true;
  nixpkgs.overlays = [
    (self: super: {
      tailscale = super.tailscale.overrideAttrs (oldAttrs: {
        doCheck = false;
      });
    })
  ];
  services.geoclue2.enable = true;
  services.tailscale.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.syncthing = {
    enable = true;
    user = "sa9m";
    dataDir = "~/.syncthing/sync"; 
    configDir = "~/.config/syncthing";
  };


  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };   

  # Open ports in the firewall.
  networking.firewall = {
  enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }  # KDE Connect
      { from = 22; to = 22; }      # SSH
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }  # KDE Connect
    ];
  };     
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}

