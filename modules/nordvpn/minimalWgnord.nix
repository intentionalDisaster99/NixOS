{ config, lib, pkgs, ... }:

let
  cfg = config.services.wgnord;

  # Standard WireGuard Template with DNS
  # We let wg-quick handle the DNS logic natively
  template = pkgs.writeText "wgnord-template.conf" ''
    [Interface]
    PrivateKey = PRIVKEY
    Address = 10.5.0.2/32
    MTU = 1350
    DNS = 103.86.96.100, 103.86.99.100

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

    networking.firewall.checkReversePath = "loose";

    environment.systemPackages = [ pkgs.wgnord pkgs.wireguard-tools pkgs.systemd ];

    systemd.services.wgnord = {
      description = "Nord Wireguard VPN";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      path = [
        pkgs.wgnord
        pkgs.wireguard-tools
        pkgs.iproute2
        pkgs.iptables
        pkgs.systemd
        pkgs.gnused
        pkgs.gnugrep
        pkgs.coreutils
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
          ${lib.getExe pkgs.wgnord} login "$(<${cfg.tokenFile})"
        '';

        ExecStart = "${lib.getExe pkgs.wgnord} connect \"${cfg.country}\"";
        ExecStop = "-${lib.getExe pkgs.wgnord} disconnect";

        Restart = "on-failure";
        RestartSec = 5;
        RemainAfterExit = "yes";
      };
    };
  };
}
