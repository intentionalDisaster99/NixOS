{ config
, pkgs
, inputs
, ...
}:
{
  imports = [
    inputs.nordvpn-nix.nixosModules.default
  ];
  custom.services.nordvpn = {
    enable = true;
  };
  users.users.sa9m.extraGroups = [ "nordvpn" ];
  environment.systemPackages = with pkgs; [
    openresolv
    nftables
    wireguard-tools
  ];
}
