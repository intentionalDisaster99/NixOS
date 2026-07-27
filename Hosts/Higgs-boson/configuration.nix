{ config
, pkgs
, inputs
, ...
}:

# Note to self: to edit secrets, run `sops secrets/secrets.yaml`

{
  imports = [
    ./hardware-configuration.nix
    ../default.nix
  ];

  # Change the hostname here if you so desire
  networking.hostName = "higgs-boson";


  # Hibernation and swap
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16GB
    }
  ];
  boot.kernelParams = [
    "resume=UUID=606544fb-61ec-4f34-99fe-b9dde180c05e"
    "resume_offset=116987904"
    "usbhid.quirks=0x04f3:0c00:0x0040"
  ];
  boot.resumeDevice = "/dev/disk/by-uuid/606544fb-61ec-4f34-99fe-b9dde180c05e";

}
