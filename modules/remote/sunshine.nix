# This is for sunshine, the server for remote gaming (you know, theoretically)

{ config, pkgs, ... }: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    settings = {
      output_name = "HEADLESS-1";
    };
  };

  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "sa9m";
  # };
  # services.displayManager.defaultSession = "hyprland-uwsm";
}
