# This is for sunshine, the server for remote gaming (you know, theoretically)

{ config, pkgs, ... }: {
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
