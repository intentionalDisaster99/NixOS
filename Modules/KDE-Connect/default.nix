# System level edits to the firewall to allow KDE connect
{ users, config, pkgs, inputs, username, ... }:

{

  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };


  home-manager-users.${username} = {
    services.kdeconnect.enable = true;
  };
}
