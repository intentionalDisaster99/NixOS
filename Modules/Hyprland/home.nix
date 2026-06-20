
# Enables hyprland and everything that I use with hyprland (like noctalia)
# This is the Home-manager module, note that there is also a required System module, because we need to run it with UWSM

{ pkgs, hyprland, config, inputs, ...}:

{

  imports = [
    ./../Noctalia/home.nix
    # ./../ # Kitty (which should import fish and starship)
  ];

  home.packages = with pkgs; [
    kitty
    xdg-desktop-portal-gtk
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    nerd-fonts.noto
    hyprcursor

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

  # Symlinking to my dots
  home.file.".config/hypr" = {
    # Notice we are building a string using your home directory, 
    # not a relative Nix path.
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hyprland/Dots";
  };

}
