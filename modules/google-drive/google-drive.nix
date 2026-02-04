{ config, pkgs, lib, ... }:

{
  options.services.google-drive-mount = {
    enable = lib.mkEnableOption "Google Drive FUSE mount";
    mountPath = lib.mkOption {
      type = lib.types.str;
      default = "GDrive/MyDrive";
      description = "Path relative to home directory to mount Google Drive.";
    };
  };

  config = lib.mkIf config.services.google-drive-mount.enable {
    environment.systemPackages = [ pkgs.google-drive-ocamlfuse ];

    systemd.user.services.google-drive-mount = {
      description = "Mount Google Drive via ocamlfuse";
      after = [ "network-online.target" ];
      wantedBy = [ "default.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse %h/${config.services.google-drive-mount.mountPath}";
        ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/${config.services.google-drive-mount.mountPath}";
        Restart = "on-failure";
        RestartSec = "10s";
      };

      preStart = "${pkgs.coreutils}/bin/mkdir -p %h/${config.services.google-drive-mount.mountPath}";
    };
  };
}
