{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  sops.secrets.smb_password = { };

  sops.templates."smb-secrets".content = ''
    username=sa9m
    password=${config.sops.placeholder.smb_password}
  '';

  fileSystems."/home/sa9m/NAS" = {
    device = "//100.85.53.124/share";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"

      "x-systemd.mount-timeout=5s"
      "x-systemd.idle-timeout=60"

      "uid=1000"
      "gid=1000"
      "file_mode=0777"
      "dir_mode=0777"

      "sec=ntlmssp"

      "credentials=${config.sops.templates."smb-secrets".path}"
    ];
  };
}
