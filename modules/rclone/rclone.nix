{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.rclone ];

  environment.etc."rclone.conf".text = ''
        # Google Drive
        [gdrive]
      type: drive
    client_id: 935963070500-1s0tcq7a52khcpmrd88f451mu9g28gvq.apps.googleusercontent.com
    client_secret: REDACTED
    scope: drive
    token: {"access_token":"ya29.a0AQQ_BDRZEgh50jmreFJsaNtxkxu3Fu3rGIaEME-T9l1g9UjED0IKNDty09WE_yHb_eMm_65tJmhjyDZmzWIRNxbdtewAxUusfBmjAfD5dSiJcaxEUD9gyXF3O-8smOS7envRPJzrgqqIef24PUa9-ppvfSds4fOvspcZpyuhdZUqcrheqH97EUQcWSgIKY8WxhBfzHIaCgYKAcUSARcSFQHGX2MiGlx1Uwz9FEuiiB7pIOSv3A0206","token_type":"Bearer","refresh_token":"1//01YcyVzYn3eIACgYIARAAGAESNwF-L9IrmlqQeObfFLEGwrVntjDiZ7Uldw2UM4p-IiBoVT3I0tWsoKFj1IqqeGRxnz_wWtTCs4I","expiry":"2025-10-01T14:05:20.364781868-05:00","expires_in":3599}
    
        # my Nas
        [NAS]
        type: smb
    host: graviton
    pass: LD6JWri2w-Hqy81goeYRu5-e1m0Cc2esUQ
  '';

  # Adding in folders if they aren't already there
  systemd.tmpfiles.rules = [
    "d /home/sa9m/GDrive 0755 sa9m users -",
    "d /home/sa9m/NAS    0755 sa9m users -",
  ];

  fileSystems = {
    "/home/sa9m/GDrive/My Drive" = {
      device = "gdrive:/"; # 'gdrive' matches the name in brackets above, ':/' means the root
      fsType = "rclone";
      options = [
        "allow_other"
        "nofail" # Prevents boot failure if the remote is unavailable
        "config=/etc/rclone.conf"
      ];
    };

    "/home/sa9m/NAS" = {
      device = "NAS:/"; # 'smb-share' matches the name in brackets above
      fsType = "rclone";
      options = [
        "allow_other"
        "nofail"
        "config=/etc/rclone.conf"
      ];
    };
  };

  # Note to future me if I ever make my repo public
  # ! SECURITY NOTE: For better security, consider using `sops-nix` or `age`
  # to encrypt your rclone.conf file instead of storing tokens directly here,
  # especially if your configuration is in a public Git repository.
}
