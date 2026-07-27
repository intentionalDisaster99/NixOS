{ config, pkgs, inputs, ... }:

# Note to self: to edit secrets, run `sops secrets/secrets.yaml`

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  # Change the hostname here if you so desire
  networking.hostName = "gluon";
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
  # TODO I, uhh, haven't bothered to set up hibernation on my PC yet
  # boot.kernelParams = [
  #   "resume=UUID=606544fb-61ec-4f34-99fe-b9dde180c05e"
  #   "resume_offset=116987904"
  #   "usbhid.quirks=0x04f3:0c00:0x0040"
  # ];
  # boot.resumeDevice = "/dev/disk/by-uuid/606544fb-61ec-4f34-99fe-b9dde180c05e";
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

}
