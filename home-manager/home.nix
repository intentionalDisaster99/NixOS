{ pkgs, ... }:

{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";

  systemd.user.startServices = "sd-switch";

  home.packages = [
    pkgs.rclone
  ];

  
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

  #######################
  ### Systemd Services###
  #######################
# ~/.config/home-manager/home.nix
  systemd.user.services.rclone-gdrive = {
    enable = true;
    description = "Rclone mount for GDrive";
    wantedBy = [ "default.target" ];
    after = [ "network-online.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.rclone}/bin/rclone mount GDrive: /home/sa9m/GDrive --vfs-cache-mode writes";
      ExecStop = "${pkgs.fusermount}/bin/fusermount -u /home/sa9m/GDrive";
      Restart = "on-failure";
    };
  };



  home.stateVersion = "23.11";
}
