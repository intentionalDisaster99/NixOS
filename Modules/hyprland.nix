
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


    # extraConfig = ''
    #''
  };
}
