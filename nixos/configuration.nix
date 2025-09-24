# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  home-manager,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    ../modules/syncthing/default.nix
    # ../modules/minesddm/default.nix

    # Home-manager
    home-manager.nixosModules.home-manager
    # ../home-manager/home.nix    
    
  ];


  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
      # (final: prev: {
      #   waybar = import ../modules/hypr/waybar/default.nix {
      #     inherit (prev) lib pkgs;
      #     waybar = prev.waybar;
      #     version = "0.10.4";
      #   };
      # })


    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # permittedInsecurePackages = [
      #   "libsoup-2.74.3"
      # ];
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      # flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };

    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  

  # Programs available to all users
  environment.systemPackages = with pkgs; [

    # Core Essentials
    grub2
    os-prober
    networkmanager
    gtk4
    
    # OS Essentials
    git
    github-desktop
    zoxide
    fastfetch
    libnotify
    tesseract4
    gImageReader
    zoom-us
    eyedropper
    syncthing
    # ulauncher
    ffmpeg_6
    neohtop

    # KDE things 
    # kdewalletmanager
    # kdePackages.kwallet
    upower
    xdg-desktop-portal
    xdg-desktop-portal-gtk

    # Hyprland
    dunst
    pipewire
    wireplumber
    hyprpaper
    swaylock-fancy
    waybar
    brightnessctl

    # Coding
    vim
    kitty
    vscode
    vscodium
    kdePackages.yakuake 
    arduino-ide
    cargo
    rustc
    python3
    jdk


    # General
    brave 
    spotify
    obsidian
    discord
    steam


    # Networking
    # geteduroam    
    tailscale

    # Gaming
    prismlauncher

  ];

  # Any aliases
  programs.bash.shellAliases = {
    cd = "z";
    nrs = "/etc/nixos/scripts/nrs.sh";
    windows = "sudo grub-reboot 1 && reboot";
    pioStart = "nix run --impure github:xdadrm/nixos_use_platformio_patformio-ide_and_vscode#codium --";
  };

  # Showing off my nerdiness
  networking.hostName = "higgs-boson";

  users.users = {
    sa9m = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "audio" "dialout"];
    };
  };

  # Home manager users block inside the NixOS config
  home-manager.users = {
    sa9m = import ../home-manager/home.nix { pkgs = pkgs; };
  };

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
  # Takes absolute ages so commented for now 
  boot.loader.grub.useOSProber = false;

  # Extra config options
  # Time zone
  time.timeZone = "America/Chicago";

  # Enable xwayland so I can actually display stuff
  services.xserver.enable = true;

  # Gaming
  programs.steam.enable = true;

  # Nice SDDM so that I can switch between Hyprland and KDE
  services.displayManager.sddm.enable = true;
  # services.xserver.sddm.enable = true;
  # services.displayManager.sddm.enable = true;

  # KDE and Hyprland enabling
  programs.hyprland.enable = true;
  xdg.portal.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Make sure everyone gets wifi 
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;

  services.dbus.packages = with pkgs; [
    # kwalletmanager
    upower
  ];


  # Enable sound with pipewire.
  # services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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


  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  # Syncthing
  services.syncthing = {
    enable = true;
    user = "sa9m";
    dataDir = "/home/sa9m";  # default location for new folders
    configDir = "/home/sa9m/.config/syncthing";
  };

  # Allowing certain things through the firewall
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

  services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.openocd
  ];

  # For platformio
  programs.nix-ld.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
