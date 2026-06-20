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
  ];


  # Symlinking to my dots
  home.file.".config/pypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Pyprland/Dots";
  };



}
