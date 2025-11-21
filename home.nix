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
    addKeysToAgent = "yes";
  };

  # You can also configure Git here if you haven't already!
  programs.git = {
    enable = true;
    userName = "Sam Whitlock";
    userEmail = "your_email@example.com"; # <--- Replace this!
  };
}
