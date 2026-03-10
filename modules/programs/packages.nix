# This module is for enabling system-wide programs and services.
{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [

    # ---------------------------------------------------
    # OS Utils 
    # ---------------------------------------------------
    grub2
    os-prober
    networkmanager
    gtk4
    polkit_gnome
    gsettings-desktop-schemas
    glib-networking
    gvfs
    upower
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    nixpkgs-fmt

    # ---------------------------------------------------
    # Hyprland
    # ---------------------------------------------------
    eww
    quickshell
    waybar
    rofi
    wlogout
    hyprpaper
    swaylock-fancy
    dunst
    libnotify
    mpvpaper
    avizo
    unclutter
    kdePackages.qt6ct
    libsForQt5.qt5ct

    # Screen capture & clipboards
    grim
    slurp
    swappy
    eyedropper
    wl-clipboard
    cliphist
    wtype

    # Audio & Display control
    pipewire
    wireplumber
    pavucontrol
    playerctl
    brightnessctl
    ffmpeg_6

    # GUI widget/script dependencies (Crucial for eww/quickshell!)
    jq
    socat
    pamixer
    acpi
    iw
    bluez
    bc
    pulseaudio
    imagemagick

    # ---------------------------------------------------
    # Terminal stuff
    # ---------------------------------------------------
    fish
    starship
    kitty
    kdePackages.yakuake
    zoxide
    fastfetch
    hyfetch
    lsd
    eza
    bat
    fzf
    ripgrep
    tldr
    dust
    lf
    psmisc
    parallel
    atuin
    direnv
    mise
    wget

    # ---------------------------------------------------
    # Dev
    # ---------------------------------------------------
    vim
    neovim
    vscode
    vscodium-fhs
    arduino-ide
    platformio
    jdk
    netbeans
    python3
    gcc
    gdb
    gef
    git
    github-desktop
    lazygit
    radicle-tui

    # Rust specific
    cargo
    rustup

    # ---------------------------------------------------
    # Embedded stuff 
    # ---------------------------------------------------
    picotool
    probe-rs-tools
    pico-sdk
    python313Packages.cmake
    gnumake42
    cargo-generate
    tio

    # ---------------------------------------------------
    # Server and utilities things
    # ---------------------------------------------------
    docker
    docker-compose
    virt-manager
    qemu
    freerdp
    rustdesk-flutter
    openssh
    sshfs
    cifs-utils
    syncthing
    rclone
    google-drive-ocamlfuse
    grsync
    gparted
    kdePackages.filelight
    usbutils
    ventoy-full
    wine
    bottles
    swtpm
    firejail
    winboat

    # System monitoring
    btop-cuda
    htop
    s-tui
    powertop
    cpu-x
    tlp
    lm_sensors
    sysprof

    # Networking
    geteduroam
    tailscale
    wgnord
    openvpn
    networkmanagerapplet
    blueman # backup bluetooth manager `blueman-manager`
    overskride

    # ---------------------------------------------------
    # General Apps
    # ---------------------------------------------------
    brave
    spotify
    discord
    element-desktop
    zoom-us
    obs-studio
    vlc
    cheese
    nautilus
    gnome-control-center
    gnome-online-accounts
    seahorse
    wofi-emoji
    emote
    qalculate-gtk

    # ---------------------------------------------------
    # School
    # ---------------------------------------------------
    obsidian
    libreoffice-qt6-fresh
    texliveFull
    pandoc
    drawio
    tesseract4
    gImageReader
    ocrmypdf

    # ---------------------------------------------------
    # Electrical
    # ---------------------------------------------------
    kicad

    # ---------------------------------------------------
    # Gaming
    # ---------------------------------------------------
    steam
    prismlauncher

    # ---------------------------------------------------
    # Silly Things
    # ---------------------------------------------------
    activate-linux
    kittysay
    neo-cowsay
    sl
    pay-respects
    gping
    fireplace
    figlet
    # mapscii

    # ---------------------------------------------------
    # Not needed/wanted (Kept for reference)
    # ---------------------------------------------------
    # mathematica
    # jetbrains.idea-ultimate
    # logisim-evolution
    # quartus-prime-lite
    # kdewalletmanager
    # kdePackages.kwallet
  ];
}
