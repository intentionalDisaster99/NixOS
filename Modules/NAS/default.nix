# TODO get this working
# I think technically I have sops set up now, but I haven't worked on this since then
{ users, config, pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    cifs-utils
  ];

  # This doesn't have my stuff in it yet because I haven't set up sops-nix
  fileSystems."/mnt/share" = {
    device = "//192.168.1.88/share"; # Replace with your server IP and share name
    fsType = "cifs";
    options = [
      "username=yourusername"
      "password=yourpassword"
      "x-systemd.automount"
      "noauto"
    ];
  };

}
