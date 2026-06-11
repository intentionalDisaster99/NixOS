
# Enables hyprland and everything that I use with hyprland (like noctalia)

{ pkgs, hyprland, config, inputs, ...}:

{

  imports = [
    # ./noctalia.nix
  ];

  home.packages = with pkgs; [
    kitty
    xdg-desktop-portal-gtk
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    nerd-fonts.noto
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
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  # Configuration stuff goes past here
  wayland.windowManager.hyprland = {
    enable = true;
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
