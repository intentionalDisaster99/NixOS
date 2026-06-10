
# Enables hyprland and everything that I use with hyprland (like noctalia)

{ pkgs, hyprland, config, inputs, ...}:

{

  imports = [
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    kitty
  ];

  # Using Cachix as a cache so that I don't have to compile from source
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  # I want the dev version so that I can use plugins (apparently that's required)
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enabling screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };



  # Configuration stuff goes past here

  wayland.windowManager.hyprland = {
    systemd.enable = false;
    settings = {
      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bind = [
        # Execute Rofi with only the SUPER key
        # "$mod, Super_L, exec, pkill rofi || rofi -show drun"

        # "$mod, F, exec, librewolf"
        "$mod, T, exec, kitty"

      ];

      # Startup Apps
      exec-once = [
        "noctalia-shell"
        # TODO add in an autostart fish function (I have found that one is very useful)
      ];

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };

}