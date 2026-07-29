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
  systemd.services.nordvpn.path = with pkgs; [
    nftables
    iptables
    iproute2
  ];
  systemd.tmpfiles.rules = [
    "d /run/nordvpn 0755 root root -"
  ];
  networking.firewall.trustedInterfaces = [ "nordlynx" ];
  services.resolved.enable = true;
}
