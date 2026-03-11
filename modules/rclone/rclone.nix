{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];

  systemd.tmpfiles.rules = [
    "d /home/sa9m/NAS 0755 sa9m users -"
  ];

  sops.secrets.rclone_nas_password = { };

  sops.templates."rclone.conf".content = ''
    [NAS]
    type = smb
    host = graviton
    pass = ${config.sops.placeholder.rclone_nas_password}
  '';

  fileSystems."/home/sa9m/NAS" = {
    device = "NAS:/";
    fsType = "rclone";
    options = [
      "allow_other"
      "_netdev"
      "nofail"
      "config=${config.sops.templates."rclone.conf".path}"
      "vfs-cache-mode=full"
      "vfs-cache-max-age=24h"
      "vfs-cache-max-size=2G"
      "uid=1000"
      "gid=100"
    ];
  };
}
