{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.google-drive-ocamlfuse pkgs.fuse ];

  systemd.user.services.google-drive-mount = {
    description = "Google Drive Mount";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse %h/GDrive/MyDrive";
      ExecStop = "${pkgs.fuse}/bin/fusermount -u %h/GDrive/MyDrive";
      Restart = "on-failure";
      Type = "forking";
    };
    preStart = "${pkgs.coreutils}/bin/mkdir -p %h/GDrive/MyDrive";
  };
}
