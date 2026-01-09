{ config, lib, pkgs, ... }:

let
  cfg = config.services.wgnord;

  wgnord = pkgs.wgnord;
  wgTools = pkgs.wireguard-tools;

  template = pkgs.writeText "wgnord-template.conf" ''
    [Interface]
    PrivateKey = PRIVKEY
    Address = 10.5.0.2/32
    MTU = 1350
    PostUp = resolvectl dns %i 103.86.96.100 103.86.99.100; resolvectl domain %i ~.;
    PreDown = resolvectl revert %i

    [Peer]
    PublicKey = SERVER_PUBKEY
    AllowedIPs = 0.0.0.0/0, ::/0
    Endpoint = SERVER_IP:51820
    PersistentKeepalive = 25
  '';
in
{
  options.services.wgnord = {
    enable = lib.mkEnableOption "NordVPN Wireguard Service";
    country = lib.mkOption {
      type = lib.types.str;
      default = "United States";
      description = "The country to connect to via NordVPN.";
    };
    tokenFile = lib.mkOption {
      type = lib.types.path;
      description = "Path to the file containing the NordVPN access token.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ wgnord wgTools pkgs.iproute2 pkgs.openresolv ];

    systemd.services.wgnord = {
      description = "Nord Wireguard VPN";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      path = [
        wgnord
        wgTools
        pkgs.iproute2
        pkgs.iptables
        pkgs.systemd
      ];

      serviceConfig = {
        Type = "oneshot";
        StateDirectory = "wgnord";
        StateDirectoryMode = "0700";

        ExecStartPre = pkgs.writeShellScript "wgnord-pre" ''
          set -e
          mkdir -p /var/lib/wgnord
          mkdir -p /etc/wireguard
          chmod 700 /var/lib/wgnord /etc/wireguard
          ln -fs ${template} /var/lib/wgnord/template.conf
          ${lib.getExe wgnord} login "$(<${cfg.tokenFile})"
        '';

        ExecStart = "${lib.getExe wgnord} connect \"${cfg.country}\"";
        ExecStop = "-${lib.getExe wgnord} disconnect";

        Restart = "on-failure";
        RestartSec = 5;
        RemainAfterExit = "yes";
      };
    };
  };
}
