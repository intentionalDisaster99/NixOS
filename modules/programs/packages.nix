# This module is for enabling system-wide programs and services.
{ config, pkgs, lib, ... }:

{
  # List packages you want to install system-wide.
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
    ffmpeg_6
    neohtop
    rclone
    libreoffice-qt6-fresh
    virt-manager
    qemu
    wine
    bottles
    gparted
    kdePackages.filelight
    swtpm
    nixpkgs-fmt
    winboat
    docker-compose
    docker
    freerdp
    wgnord

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
    #    rustc
    python3
    platformio
    jdk
    rustup
    gcc

    # Electrical
    kicad


    # General
    brave
    spotify
    obsidian
    discord
    steam
    element-desktop
    obs-studio

    # Networking
    # geteduroam    
    tailscale

    # Gaming
    prismlauncher

  ];

}
