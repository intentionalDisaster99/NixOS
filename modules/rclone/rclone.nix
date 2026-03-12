{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];

  systemd.tmpfiles.rules = [
    "d /mnt/NAS 0755 sa9m users -"
  ];

  sops.secrets.smb_password = { };

  sops.templates."rclone.conf".content = ''
    [NAS]
    type = smb
    host = graviton
    pass = ${config.sops.placeholder.smb_password}
  '';

  fileSystems."/mnt/NAS" = {
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
