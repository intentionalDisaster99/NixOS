# This module is for enabling system-wide programs and services.
{ config, pkgs, pkgs-latest, lib, inputs, ... }:

{
  environment.systemPackages = [

    # ---------------------------------------------------
    # OS Utils 
    # ---------------------------------------------------
    pkgs.grub2
    pkgs.os-prober
    pkgs.networkmanager
    pkgs.gtk4
    pkgs.polkit_gnome
    pkgs.gsettings-desktop-schemas
    pkgs.glib-networking
    pkgs.gvfs
    pkgs.upower
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-gtk
    pkgs.nixpkgs-fmt
    pkgs.nix-output-monitor
    pkgs.nh

    # ---------------------------------------------------
    # Hyprland
    pkgs.# ---------------------------------------------------
    pkgs.eww
    pkgs.quickshell
    pkgs.waybar
    pkgs.rofi
    pkgs.wlogout
    pkgs.hyprpaper
    pkgs.swaylock-fancy
    pkgs.dunst
    pkgs.libnotify
    pkgs.mpvpaper
    pkgs.avizo
    pkgs.unclutter
    pkgs.kdePackages.qt6ct
    pkgs.kdePackages.breeze
    pkgs.libsForQt5.qt5ct

    # Screen capture & clipboards
    pkgs.grim
    pkgs.slurp
    pkgs.swappy
    pkgs.eyedropper
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.wtype
    pkgs.jq

    # Audio & Display control
    pkgs.pipewire
    pkgs.wireplumber
    pkgs.pavucontrol
    pkgs.playerctl
    pkgs.brightnessctl
    pkgs.ffmpeg_6

    # GUI widget/script dependencies (Crucial for eww/quickshell!)
    pkgs.jq
    pkgs.socat
    pkgs.pamixer
    pkgs.acpi
    pkgs.iw
    pkgs.bluez
    pkgs.bc
    pkgs.pulseaudio
    pkgs.imagemagick

    # ---------------------------------------------------
    # Terminal stuff
    # ---------------------------------------------------
    pkgs.fish
    pkgs.starship
    pkgs.kitty
    pkgs.kdePackages.yakuake
    pkgs.zoxide
    pkgs.fastfetch
    pkgs.hyfetch
    pkgs.lsd
    pkgs.eza
    pkgs.bat
    pkgs.fzf
    pkgs.ripgrep
    pkgs.tldr
    pkgs.dust
    pkgs.lf
    pkgs.psmisc
    pkgs.parallel
    pkgs.atuin
    pkgs.direnv
    pkgs.mise
    pkgs.wget

    # ---------------------------------------------------
    # Dev
    # ---------------------------------------------------
    pkgs.vim
    pkgs.nano
    pkgs.neovim
    pkgs.vscode
    pkgs.vscodium-fhs
    pkgs.arduino-ide
    pkgs.platformio
    pkgs.jdk
    pkgs.tmux
    # pkgs.netbeans
    pkgs.python3
    pkgs.gcc
    pkgs.gdb
    pkgs.gef
    pkgs.git
    pkgs.github-desktop
    pkgs.lazygit
    pkgs.radicle-tui
    pkgs.curl

    # Rust specific
    pkgs.cargo
    pkgs.rustup

    # ---------------------------------------------------
    # Embedded stuff 
    # ---------------------------------------------------
    pkgs.picotool
    pkgs.probe-rs-tools
    pkgs.pico-sdk
    pkgs.python313Packages.cmake
    pkgs.gnumake42
    pkgs.cargo-generate
    pkgs.tio

    # ---------------------------------------------------
    # Server and utilities things
    # ---------------------------------------------------
    pkgs.docker
    pkgs.docker-compose
    pkgs.virt-manager
    pkgs.qemu
    pkgs.freerdp
    pkgs.openssh
    pkgs.sshfs
    pkgs.cifs-utils
    pkgs.syncthing
    pkgs.rclone
    pkgs.google-drive-ocamlfuse
    pkgs.grsync
    pkgs.gparted
    pkgs.kdePackages.filelight
    pkgs.usbutils
    pkgs.ventoy-full
    pkgs.wine
    pkgs.bottles
    pkgs.swtpm
    pkgs.firejail
    pkgs.winboat
    pkgs.waypipe
    pkgs.comma

    # System monitoring
    pkgs.btop-cuda
    pkgs.htop
    pkgs.s-tui
    pkgs.powertop
    pkgs.cpu-x
    pkgs.tlp
    pkgs.lm_sensors
    pkgs.sysprof

    # Networking
    pkgs.geteduroam
    pkgs.tailscale
    pkgs.wgnord
    pkgs.openvpn
    pkgs.networkmanagerapplet
    pkgs.blueman # backup bluetooth manager `blueman-manager`
    pkgs.overskride

    # ---------------------------------------------------
    # General Apps
    # ---------------------------------------------------
    pkgs.brave
    pkgs.spotify
    pkgs.discord
    pkgs.element-desktop
    pkgs.zoom-us
    pkgs-latest.rustdesk-flutter
    # pkgs-latest.rustdesk
    pkgs.obs-studio
    pkgs.davinci-resolve
    pkgs.kdePackages.kdenlive
    pkgs.vlc
    pkgs.blender
    pkgs.cheese
    pkgs.nautilus
    pkgs.gnome-control-center
    pkgs.gnome-online-accounts
    pkgs.seahorse
    pkgs.wofi-emoji
    pkgs.emote
    pkgs.qalculate-gtk
    pkgs.kdePackages.gwenview
    pkgs.kdePackages.dolphin
    pkgs.kdePackages.dolphin-plugins
    pkgs.desktop-file-utils
    pkgs.kdePackages.plasma-workspace
    pkgs.kdePackages.ark
    pkgs.kdePackages.kio
    pkgs.kdePackages.kio-extras
    pkgs.xdg-utils
    pkgs.shared-mime-info
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.libsForQt5.qtstyleplugin-kvantum
    pkgs.gruvbox-dark-gtk
    pkgs.gruvbox-plus-icons

    # ---------------------------------------------------
    # School
    # ---------------------------------------------------
    pkgs.obsidian
    pkgs.libreoffice-qt6-fresh
    pkgs.texliveFull
    pkgs.pandoc
    pkgs.drawio
    pkgs.tesseract4
    pkgs.gImageReader
    pkgs.ocrmypdf

    # ---------------------------------------------------
    # Electrical
    # ---------------------------------------------------
    pkgs.kicad

    # ---------------------------------------------------
    # Gaming
    # ---------------------------------------------------
    pkgs.steam
    pkgs.prismlauncher

    # ---------------------------------------------------
    # Silly Things
    # ---------------------------------------------------
    pkgs.activate-linux
    pkgs.kittysay
    pkgs.neo-cowsay
    pkgs.fortune
    pkgs.sl
    pkgs.pay-respects
    pkgs.gping
    pkgs.fireplace
    pkgs.figlet
    pkgs.mapscii
    pkgs.nyancat
    pkgs.cbonsai
    pkgs.asciiquarium
    pkgs.xcowsay
    pkgs.pipes
    pkgs.lolcat
    pkgs.golazo
    # aewan # Technically could be quite cool, but I don't really want to put the effort into learning it
    # inputs.terminal-rain.packages.${stdenv.hostPlatform.system}.terminal-rain-lightning
    pkgs.pywal


    # ---------------------------------------------------
    # Not needed/wanted (Kept for reference)
    # ---------------------------------------------------
    # mathematica
    # blender
    pkgs.jetbrains.idea
    # logisim-evolution
    # quartus-prime-lite
    # kdewalletmanager
    adb-sync
    # kdePackages.kwallet
  ];

}
