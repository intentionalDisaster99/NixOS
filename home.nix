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
      user.name = "Sam Whitlock";
      user.email = "abyssalflerken@gmail.com";
    };
  };

  ################
  # Default Apps #
  ################
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "brave-browser.desktop";
      "x-scheme-handler/http" = "brave-browser.desktop";
      "x-scheme-handler/https" = "brave-browser.desktop";
      "x-scheme-handler/about" = "brave-browser.desktop";
      "x-scheme-handler/unknown" = "brave-browser.desktop";

      "application/pdf" = "brave-browser.desktop"; # Or a specific PDF reader
      "image/png" = "imv.desktop"; # Or whatever image viewer you use
      "image/jpeg" = "imv.desktop";

      # Optional: Set VSCode for code files
      "text/plain" = "code.desktop";
      "application/json" = "code.desktop";
    };
  };
}
