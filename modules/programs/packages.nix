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
    rclone
    btop-cuda
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
    ventoy-full
    rustdesk-flutter
    google-drive-ocamlfuse
    lsd
    tldr
    htop
    networkmanagerapplet
    neovim
    seahorse
    lm_sensors
    wget
    texliveFull
    cliphist
    wl-clipboard
    wtype
    pavucontrol
    swappy
    firejail
    playerctl
    fzf
    cifs-utils
    grsync
    wofi-emoji
    nautilus
    gnome-control-center
    gnome-online-accounts
    gvfs
    polkit_gnome
    seahorse
    glib-networking
    sysprof
    gsettings-desktop-schemas
    s-tui
    mpvpaper
    openssh
    sshfs
    tlp
    powertop
    cpu-x
    unclutter
    eza
    hyfetch
    ocrmypdf
    parallel
    atuin
    bat
    fzf
    fireplace
    usbutils
    blueman # backup bluetooth manager `blueman-manager`
    pandoc
    emote
    direnv
    cheese
    drawio

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
    rofi
    wlogout
    fish
    grim
    slurp
    wl-clipboard
    kdePackages.qt6ct
    libsForQt5.qt5ct
    starship
    direnv
    mise
    figlet
    overskride
    psmisc
    ripgrep
    avizo
    radicle-tui
    qalculate-gtk


    # Coding
    vim
    kitty
    vscode
    vscodium-fhs
    kdePackages.yakuake
    arduino-ide
    cargo
    #    rustc
    python3
    platformio
    jdk
    rustup
    gcc
    lazygit
    openvpn
    netbeans
    # jetbrains-toolbox
    vlc
    gdb
    gef

    # Funy
    activate-linux

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
    geteduroam
    tailscale

    # Gaming
    prismlauncher

    # Rust embedded
    picotool
    probe-rs-tools
    # cmake
    gnumake42
    pico-sdk
    python313Packages.cmake
    direnv
    cargo-generate
    tio

    # Silly
    kittysay
    neo-cowsay
    sl
    pay-respects
    gping
    lf

    # School
    # mathematica
    # Not needed/wanted
    jetbrains.idea-ultimate
    # logisim-evolution
    # quartus-prime-lite

    # TMP
    # mapscii


  ];


}
