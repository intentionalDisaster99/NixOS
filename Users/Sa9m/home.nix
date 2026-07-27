#
# This is my home-manager entrypoint, so where I define my sa9m user.
# If you are wanting to use my config, you can change your settings here (or copy this to have more users)
#

{ config
, pkgs
, inputs
, ...
}:
{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";

  imports = [

    # All of the program home manageing
    ./../../Modules/Fish/home.nix
    ./../../Modules/Hyprland/home.nix
    ./../../Modules/Hypridle/home.nix
    ./../../Modules/Spotify/home.nix
    ./../../Modules/Obsidian/home.nix
    ./../../Modules/KDE-Connect/home.nix
    ./../../Modules/Funny/home.nix
    ./../../Modules/NVim/home.nix

    # Resource movement
    ./../../Resources/Profile/profile.nix
    ./../../Resources/Wallpaper/wallpaper.nix
  ];

  # Everything that isn't installed here will be imported in modules, so I only have a few basic things here
  home.packages = with pkgs; [
    brave
    vscode
    discord
    kdePackages.dolphin
    nixpkgs-fmt
    nom
    slurp
    grim
    wl-clipboard
    kicad
    nh
    hyfetch
    fastfetch
    zoom-us
    ubase
    kdePackages.ark
    unzip
    libreoffice
    stm32cubemx
    openrgb
    rustdesk-flutter
    jellyfin-desktop
    # fetch
    pavucontrol
    # TODO move
    kicad
    github-desktop

    # DEBUG TODO REMOVE
    libnotify
    droidcam
    adb-sync
    v4l-utils
    android-tools
  ];

  # My basic git configuration which I will always want on my system
  programs.git = {
    enable = true;
    settings.user.name = "Sa9m";
    settings.user.email = "abyssalflerken@gmail.com";
  };

  home.stateVersion = "26.05";

}
