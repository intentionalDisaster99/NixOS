{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  sops.secrets.smb_password = { };

  # sops.templates."smb-secrets".content = ''
  #   username=sa9m
  #   password=${config.sops.placeholder.smb_password}
  # '';
  systemd.services.create-smb-credentials = {
    description = "Generate SMB credentials file safely at runtime";
    wantedBy = [ "multi-user.target" ];
    after = [ "sops-nix.service" ];
    before = [ "home-sa9m-NAS.mount" ];

    script = ''
            mkdir -p /run/secrets-custom
            cat << 'EOF' > /run/secrets-custom/smb-credentials
      username=sa9m
      password=$(cat ${config.sops.secrets.smb_password.path})
      EOF
            chmod 600 /run/secrets-custom/smb-credentials
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };

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

      "noperm"

      "sec=ntlmssp"

      "credentials=/run/secrets-custom/smb-credentials"
    ];
  };
}
