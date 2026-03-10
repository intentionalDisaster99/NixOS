{ config, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;
  isHiggs = hostname == "higgs-boson";
  isGluon = hostname == "gluon";

  activeUuid =
    if isHiggs then "7282-E320"
    else if isGluon then "1588-A8B5"
    else null;

  windowsMenuEntry = ''
    menuentry "Windows 11" --class windows {
      insmod part_gpt
      insmod fat
      insmod search_fs_uuid
      search --fs-uuid --set=root ${activeUuid}
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
in
{
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
