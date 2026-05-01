{ pkgs, inputs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.dconf.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Adding in the plugin for my desktop
  # environment.etc."hyprland/plugins/hyprsplit.so".source = "${pkgs.hyprlandPlugins.hyprsplit}/lib/libhyprsplit.so";
  environment.etc."hyprland/plugins/hyprsplit.so".source = "${pkgs.hyprlandPlugins.hyprsplit.overrideAttrs (old: {
    src = inputs.hyprsplit;
    version = "latest";
  })}/lib/libhyprsplit.so";


  programs.hyprlock.enable = true;
  security.pam.services.hyprlock.enableGnomeKeyring = true;
  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprsunset
    hyprpolkitagent
    pkgs.kio-fuse
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
    config = {
      common = {
        default = [ "hyprland" "gtk" "kde " ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
  };
}
