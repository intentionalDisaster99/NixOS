{ config, pkgs, ... }:

{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";

  xdg.configFile = {
    "hypr" = { source = ./dotfiles/hypr; recursive = true; };
    "waybar" = { source = ./dotfiles/waybar; recursive = true; };
    "kitty" = { source = ./dotfiles/kitty; recursive = true; };
    "dunst" = { source = ./dotfiles/dunst; recursive = true; };
    "rofi" = { source = ./dotfiles/rofi; recursive = true; };
    "wlogout" = { source = ./dotfiles/wlogout; recursive = true; };
    "fish" = { source = ./dotfiles/fish; recursive = true; };
    "starship.toml".source = ./dotfiles/starship.toml;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  ##################
  # Setting up SSH #
  ##################

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };

  programs.git = {
    enable = true;
    settings = {
      userName = "Sam Whitlock";
      userEmail = "abyssalflerken@gmail.com";
    };
  };
}
