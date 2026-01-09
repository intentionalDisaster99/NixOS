{ config, lib, pkgs, ... }:

let
  cfg = config.services.wgnord;

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
    networking.firewall.trustedInterfaces = [ "wgnord" ];

    environment.systemPackages = [ pkgs.wgnord pkgs.wireguard-tools pkgs.openresolv ];

    systemd.services.wgnord = {
      description = "Nord Wireguard VPN";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      path = [
        pkgs.wgnord
        pkgs.wireguard-tools
        pkgs.openresolv
        pkgs.iproute2
        pkgs.iptables
        pkgs.gnused
        pkgs.gnugrep
        pkgs.coreutils
        pkgs.bash
      ];

      serviceConfig = {
        Type = "oneshot";
        StateDirectory = "wgnord";
        StateDirectoryMode = "0700";

        # Make logs visible
        StandardOutput = "journal+console";
        StandardError = "journal+console";

        ExecStartPre = pkgs.writeShellScript "wgnord-pre" ''
          set -e
          # Safety cleanup (wrapped in true to never fail)
          ${pkgs.iproute2}/bin/ip link delete wgnord >/dev/null 2>&1 || true
          
          mkdir -p /var/lib/wgnord /etc/wireguard
          chmod 700 /var/lib/wgnord /etc/wireguard
          ln -fs ${template} /var/lib/wgnord/template.conf
          ${lib.getExe pkgs.wgnord} login "$(<${cfg.tokenFile})"
        '';

        ExecStart = "${lib.getExe pkgs.wgnord} connect \"${cfg.country}\"";

        ExecStop = "-${lib.getExe pkgs.wgnord} disconnect";

        ExecStopPost = "${pkgs.bash}/bin/bash -c '${pkgs.iproute2}/bin/ip link delete wgnord >/dev/null 2>&1 || true'";

        Restart = "on-failure";
        RestartSec = 5;
        RemainAfterExit = "yes";
      };
    };
  };
}
