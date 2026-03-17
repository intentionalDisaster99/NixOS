{ pkgs, inputs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  # Adding in the plugin for my desktop
  # environment.etc."hyprland/plugins/hyprsplit.so".source = "${pkgs.hyprlandPlugins.hyprsplit}/lib/libhyprsplit.so";
  # environment.etc."hyprland/plugins/hyprsplit.so".source = "${inputs.hyprsplit.packages.${pkgs.system}.hyprsplit}/lib/libhyprsplit.so";


  programs.hyprlock.enable = true;
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
  ];
}
