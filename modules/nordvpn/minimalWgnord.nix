{ config, lib, pkgs, ... }:

let
  cfg = config.services.wgnord;

  # The template configuration for WireGuard
  template = pkgs.writeText "wgnord-template.conf" ''
    [Interface]
    PrivateKey = PRIVKEY
    Address = 10.5.0.2/32
    MTU = 1350
    DNS = 103.86.96.100 103.86.99.100

    [Peer]
    PublicKey = SERVER_PUBKEY
    AllowedIPs = 0.0.0.0/0, ::/0
    Endpoint = SERVER_IP:51820
    PersistentKeepalive = 25
  '';
in
{
  # 1. Define the options you want to configure
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
      example = "/run/secrets/nord_token";
    };
  };

  # 2. Define the configuration that is applied when enabled
  config = lib.mkIf cfg.enable {

    # Ensure wgnord is installed so the command works
    environment.systemPackages = [ pkgs.wgnord ];

    systemd.services.wgnord = {
      description = "Nord Wireguard VPN";
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      startLimitBurst = 3;
      startLimitIntervalSec = 30;

      serviceConfig = {
        Type = "oneshot";
        StateDirectory = "wgnord";
        StateDirectoryMode = "0700";
        ConfigurationDirectory = "wireguard";
        ConfigurationDirectoryMode = "0700";

        ExecStartPre = [
          # Link the template so wgnord can find it
          "${lib.getExe' pkgs.coreutils "ln"} -fs ${template} /var/lib/wgnord/template.conf"

          # Login using the token from the configured file
          # We use bash -c to allow the $(<file) redirection
          "${lib.getExe' pkgs.bash "sh"} -c '${lib.getExe pkgs.wgnord} login \"$(<${cfg.tokenFile})\"'"
        ];

        # Connect to the configured country
        ExecStart = "${lib.getExe pkgs.wgnord} connect \"${cfg.country}\"";

        # Disconnect on stop
        # The '-' prefix tells systemd to ignore errors if it's already disconnected
        ExecStop = "-${lib.getExe pkgs.wgnord} disconnect";

        Restart = "on-failure";
        RestartSec = 10;
        RemainAfterExit = "yes";
      };
    };
  };
}
