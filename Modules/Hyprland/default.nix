{ users
, config
, pkgs
, inputs
, username
, ...
}:

{

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  # For styling of QT apps
  qt = {
    enable = true;
    platformTheme.name = "qt5ct"; # Or "kvantum" if you bypass qtct
    style.name = "kvantum";
  };

  imports = [
    ./../Noctalia/default.nix
    ./../Kitty/default.nix
    ./../Pyprland/default.nix
  ];

  home-manager.users.${username} =
    { config, ... }:
    {

      home.packages = with pkgs; [
        xdg-desktop-portal-gtk
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
        noto-fonts
        nerd-fonts.noto
        hyprcursor
        qalculate-gtk
        kdePackages.kclock

        # TODO move, these should likely be in a higher-up level (or wherevever dolphin is installed)
        zip
        libzip

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
        upower
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
          hyprland.default = [
            "hyprland"
            "gtk"
          ];
        };
      };

      # Symlinking to my dots
      xdg.configFile."hypr/hyprland.lua".source =
        config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hyprland/Dots/hyprland.lua";
      # home.file.".config/hypr/hyprland.lua" = {
      #   source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hyprland/Dots/hyprland.lua";
      # };

      home.pointerCursor = {
        name = "breeze_cursors";
        package = pkgs.kdePackages.breeze;
        size = 24;
        gtk.enable = true;
        x11.enable = true;
        # Explicitly enable hyprcursor support if using HM 24.05+
        hyprcursor.enable = true;
      };
    };
}
