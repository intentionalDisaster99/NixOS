{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  sops.secrets.smb_password = {
    sopsFile = ../../../secrets/secrets.yaml;
  };
  # Define the mount point using systemd
  fileSystems."/home/sa9m/NAS" = {
    device = "//100.85.53.124/NAS";
    fsType = "cifs";
    options = [
      # Only mounts when you access the folder
      "x-systemd.automount"
      "noauto"

      # Timeout if the NAS is down so the system doesn't freeze
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"

      # Permissions setup 
      "uid=1000"
      "gid=1000"
      "file_mode=0755"
      "dir_mode=0755"

      # Adding in the smb credentials
      "username=sa9m"
      "password=${config.sops.secrets.smb_password.path}"
    ];
  };
}
