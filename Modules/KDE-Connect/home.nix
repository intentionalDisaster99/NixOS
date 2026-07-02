# Installs and enables KDE connect so that I can connect with ma phone
{ users, config, pkgs, inputs, ... }:
{
  services.kdeconnect.enable = true;

  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

}
