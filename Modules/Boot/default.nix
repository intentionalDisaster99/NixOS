# Controls the bootloader that I use (Grub)

{ config
, pkgs
, lib
, inputs
, ...
}:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";

  # Teehee silly sddm
  services.displayManager.sddm = {
    enable = true;
    theme = "minesddm";
    wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Add the theme package itself
    inputs.minesddm.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Add the required Qt dependencies
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];

  # Actually turning the bad boi on
  boot.loader.grub = {
    enable = true;
    useOSProber = lib.mkForce false;

    extraEntries = lib.mkIf (activeUuid != null) windowsMenuEntry;

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS ${config.system.nixos.distroName}";
          lineBottom = "Survival Mode, No Cheats";
          imgName = "nixos";
        }
      ] ++ (if (activeUuid != null) then [{
        name = "windows";
        lineTop = "Windows 11";
        lineBottom = "Hardcore Mode, All Cheats Enabled";
        imgName = "windows";
      }] else [ ]);
    };
  };
}
