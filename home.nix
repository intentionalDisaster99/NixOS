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

  home.sessionVariables = {
    # Tell KDE apps to use the standard Plasma menu structure
    XDG_MENU_PREFIX = "plasma-";
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
  xdg.mimeApps =
    let
      my-associations = {
        # --- Okular ---
        "application/pdf" = "okularApplication_pdf.desktop";
        "application/vnd.comicbook+zip" = "okularApplication_comicbook.desktop";
        "application/vnd.comicbook-rar" = "okularApplication_comicbook.desktop";
        "application/x-cbz" = "okularApplication_comicbook.desktop";
        "application/x-cbr" = "okularApplication_comicbook.desktop";
        "application/epub+zip" = "okularApplication_epub.desktop";
        "application/x-mobipocket-ebook" = "okularApplication_mobi.desktop";
        "application/x-fictionbook+xml" = "okularApplication_fb.desktop";
        "image/vnd.djvu" = "okularApplication_djvu.desktop";
        "image/tiff" = "okularApplication_tiff.desktop";
        "application/x-dvi" = "okularApplication_dvi.desktop";
        "application/vnd.ms-xpsdocument" = "okularApplication_xps.desktop";
        "application/postscript" = "okularApplication_ghostview.desktop";

        # --- VSCode ---
        "text/plain" = "code.desktop";
        "text/markdown" = "code.desktop";
        "application/x-shellscript" = "code.desktop";
        "application/json" = "code.desktop";
        "application/yaml" = "code.desktop";
        "application/toml" = "code.desktop";
        "text/x-cmake" = "code.desktop";
        "text/x-python" = "code.desktop";
        "text/x-go" = "code.desktop";
        "text/rust" = "code.desktop";
        "text/x-c++src" = "code.desktop";
        "text/x-c" = "code.desktop";
        "application/javascript" = "code.desktop";
        "text/css" = "code.desktop";
        "text/html" = "code.desktop";
      };
    in
    {
      enable = true;
      # Apply the list to both places to satisfy Dolphin
      defaultApplications = my-associations;
      associations.added = my-associations;
    };
}
