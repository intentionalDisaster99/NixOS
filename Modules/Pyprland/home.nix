# Enables the scratchpads that I like to use through pyprland

{ pkgs, hyprland, config, inputs, ... }:

{


  home.packages = with pkgs; [
    pyprland
  ];


  # Symlinking to my dots
  home.file.".config/pypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Pyprland/Dots";
  };



}
