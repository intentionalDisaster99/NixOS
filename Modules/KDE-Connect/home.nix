# Installs and enables KDE connect so that I can connect with ma phone
{ users, config, pkgs, inputs, ... }:
{

  services.kdeconnect.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

}
