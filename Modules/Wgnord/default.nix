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
  # Enable the NordVPN daemon
  services.nordvpn.enable = true;

  # Add your user to the nordvpn group
  users.users.sa9m.extraGroups = [ "nordvpn" ];
  # environment.systemPackages = with pkgs; [
  #   wgnord
  #   openresolv
  #   wireguard-tools
  # ];
}
