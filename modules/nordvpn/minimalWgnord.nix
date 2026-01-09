{ config, lib, pkgs, ... }:

let
  cfg = config.services.wgnord;

  # We explicitly include wireguard-tools so wg-quick is available
  wgnord = pkgs.wgnord;
  wgTools = pkgs.wireguard-tools;

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
    # Ensure system has the tools needed for manual debugging too
    environment.systemPackages = [ wgnord wgTools pkgs.iproute2 pkgs.openresolv ];

    systemd.services.wgnord = {
      description = "Nord Wireguard VPN";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];

      # Add necessary tools to the service PATH
      path = [ wgnord wgTools pkgs.iproute2 pkgs.iptables ];

      serviceConfig = {
        Type = "oneshot";
        StateDirectory = "wgnord";
        StateDirectoryMode = "0700";

        # SCRIPT: Create dirs, link template, login
        ExecStartPre = pkgs.writeShellScript "wgnord-pre" ''
          set -e
          mkdir -p /var/lib/wgnord
          mkdir -p /etc/wireguard
          chmod 700 /var/lib/wgnord /etc/wireguard
          
          ln -fs ${template} /var/lib/wgnord/template.conf
          
          # Login (using the file content)
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
