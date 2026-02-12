{ pkgs, ... }:

let
  driveSecrets = import "${./../../secrets/google-drive.nix}";
in
{
  environment.systemPackages = [ pkgs.google-drive-ocamlfuse pkgs.fuse ];

  systemd.user.services.google-drive-mount = {
    description = "Google Drive Mount";
    wantedBy = [ "default.target" ];

    serviceConfig = {
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

    preStart = "${pkgs.coreutils}/bin/mkdir -p %h/GoogleDrive";

    postStart = ''
      ${pkgs.coreutils}/bin/sleep 2
      ${pkgs.coreutils}/bin/ln -sfn %h/GoogleDrive/.shared %h/SharedDrives
    '';
  };
}
