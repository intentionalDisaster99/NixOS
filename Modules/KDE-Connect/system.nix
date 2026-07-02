# System level edits to the firewall to allow KDE connect
{ users, config, pkgs, inputs, ... }:

{

  networking.firewall = rec {
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };

}
