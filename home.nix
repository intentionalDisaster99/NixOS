{ config, pkgs, lib, ... }:
let
  gruvbox-kvantum = pkgs.fetchFromGitHub {
    owner = "sachnr";
    repo = "gruvbox-kvantum-themes";
    rev = "main";
    sha256 = "sha256-u2J4Zf9HuMjNCt3qVpgEffkytl/t277FzOvWL8Nm8os=";
  };
in
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
    "doom" = { source = ./dotfiles/doom; };
    "nvim" = { source = ./dotfiles/nvim; recursive = true; };
    "Kvantum/Gruvbox-Dark-Brown".source =
      "${gruvbox-kvantum}/Gruvbox-Dark-Brown";

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Gruvbox-Dark-Brown
    '';
  };

  home.sessionVariables = {
    # Tell KDE apps to use the standard Plasma menu structure
    XDG_MENU_PREFIX = "plasma-";
    GIO_EXTRA_MODULES = "${pkgs.gvfs}/lib/gio/modules:${pkgs.glib-networking}/lib/gio/modules";
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
      associations = {
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

        # --- Directories ---
        "inode/directory" = "org.kde.dolphin.desktop";

        # --- Images ---
        "image/png" = "org.kde.gwenview.desktop";
        "image/jpeg" = "org.kde.gwenview.desktop";
        "image/gif" = "org.kde.gwenview.desktop";
        "image/webp" = "org.kde.gwenview.desktop";

        # --- Video ---
        "video/mp4" = "vlc.desktop";
        "video/x-matroska" = "vlc.desktop";
        "video/webm" = "vlc.desktop";

        # --- Audio ---
        "audio/mpeg" = "vlc.desktop";
        "audio/flac" = "vlc.desktop";
      };
    in
    {
      enable = true;
      # Apply the list to both places to satisfy Dolphin
      defaultApplications = associations;
      associations.added = associations;
    };
  home.activation.updateDesktopDatabase = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run cp -rn /run/current-system/sw/share/applications/. ~/.local/share/applications/ 2>/dev/null || true
    run ${pkgs.desktop-file-utils}/bin/update-desktop-database ~/.local/share/applications/
  '';

  ####################################
  ## Setting Everything to Dark Mode##
  ####################################
  gtk = {
    enable = true;
    theme = {
      name = "Gruvbox-Dark-Brown";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "Gruvbox-Plus-Dark";
      package = pkgs.gruvbox-plus-icons;
    };
  };
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  # TODO Move this to its own module
  ##################
  # Setting up Nvim#
  ##################
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      gcc
      gnumake
      unzip
      wl-clipboard
      nodejs
    ];
  };

  # TODO Move this to its own module
  # Where to save screenshots
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=/home/sa9m/Pictures/Screenshots
    save_filename_format=screenshot-%Y%m%d-%H%M%S.png
    show_panel=false
    line_size=5
    text_size=20
    text_font=sans-serif
  '';

}
