# Enables hyprland and everything that I use with hyprland (like noctalia)
# This is the Home-manager module, note that there is also a required System module, because we need to run it with UWSM

{ pkgs, hyprland, config, inputs, ... }:

{

  programs.starship = {
    # enable = true;
    enableFishIntegration = true;
    settings = { };
  };

  home.packages = with pkgs; [
    starship
  ];


  # Symlinking to my dots
  home.file.".config/starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hyprland/Dots/starship.toml";
  };

}
