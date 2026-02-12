{ pkgs, ... }:

let
  # Import the secrets from 2 folders up
  driveSecrets = import ../../secrets/google-drive.nix;
in
{
  environment.systemPackages = [ pkgs.google-drive-ocamlfuse pkgs.fuse ];

  systemd.user.services.google-drive-mount = {
    description = "Google Drive Mount";
    wantedBy = [ "default.target" ];

    serviceConfig = {
      # This is where we inject the credentials
      ExecStart = ''
        ${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse \
          -id "${driveSecrets.client_id}" \
          -secret "${driveSecrets.client_secret}" \
          %h/GoogleDrive
      '';

      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/GoogleDrive";
      Restart = "on-failure";
      Type = "forking";
    };

    # Ensure the directory exists
    preStart = "${pkgs.coreutils}/bin/mkdir -p %h/GoogleDrive";

    # Create the symlink for Shared Drives
    postStart = ''
      ${pkgs.coreutils}/bin/sleep 2
      ${pkgs.coreutils}/bin/ln -sfn %h/GoogleDrive/.shared %h/SharedDrives
    '';
  };
}
