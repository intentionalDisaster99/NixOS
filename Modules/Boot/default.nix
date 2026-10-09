# Controls the bootloader that I use (Grub)

{ config
, pkgs
, lib
, inputs
, ...
}:

{
  imports = [
    inputs.minegrub-world-sel-theme.nixosModules.default
  ];
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";


  # Teehee silly sddm
  # services.displayManager.sddm = {
  #   enable = true;
  #   theme = "minesddm";
  #   wayland.enable = true;
  # };
  environment.systemPackages = with pkgs; [
    # Add the required Qt dependencies
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];

  # Actually turning the bad boi on
  boot.loader.grub = {
    enable = true;
    useOSProber = true;

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS ${config.system.nixos.distroName}";
          lineBottom = "The right choice";
          imgName = "nixos";
        }
      ];
    };
  };
}
