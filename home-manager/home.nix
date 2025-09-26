{ pkgs, ... }:

{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";

  systemd.user.startServices = "sd-switch";
  
  
  # Enabling Programs
  # programs.waybar.enable = true;
  programs.git.enable = true;
  services.syncthing.enable = true;
  xdg.enable = true;
  programs.home-manager.enable = true;
  programs.bash.enable = true;
  programs.kitty.enable = true;
  programs.zoxide.enable = true;
  programs.brave.enable = true;
  services.kdeconnect.enable = true;


  # Linking to my config files
  home.file.".config/hypr/hyprland.conf".source = ../modules/hypr/hyprland.conf;
  home.file.".config/waybar/config".source = ../modules/hypr/waybar/config.jsonc;
  home.file.".config/waybar/style.css".source = ../modules/hypr/waybar/style.css;


  home.stateVersion = "23.11";
}
