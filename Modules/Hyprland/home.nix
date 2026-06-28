# Enables hyprland and everything that I use with hyprland (like noctalia)
# This is the Home-manager module, note that there is also a required System module, because we need to run it with UWSM

{ pkgs, hyprland, config, inputs, ... }:

{

  imports = [
    ./../Noctalia/home.nix
    ./../Kitty/home.nix
    ./../Pyprland/home.nix
  ];


  home.packages = with pkgs; [
    xdg-desktop-portal-gtk
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    nerd-fonts.noto
    hyprcursor

    # TODO Move to a better spot
    obsidian

    # Noctalia plugins TODO MOVE
    swappy
    grim
    wl-clipboard
    tesseract
    imagemagick
    zbar
    curl
    ffmpeg
    jq
    wl-screenrec
    python3
    hyprpicker
    translate-shell
  ];

  # Things that we need for Kitty (required by hyprland)
  fonts.fontconfig.enable = true;
  programs.kitty.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enabling screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  # Symlinking to my dots
  home.file.".config/hypr/hyprland.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hyprland/Dots/hyprland.lua";
  };

  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
    # Explicitly enable hyprcursor support if using HM 24.05+
    hyprcursor.enable = true;
  };

}
