{ config, pkgs, lib, ... }:

let
  hostname = config.networking.hostName;
  isHiggs = hostname == "higgs-boson";
  isGluon = hostname == "gluon";

  # Manual Windows entry
  # Note: You'll need the specific UUID for Gluon here
  windowsEntry = uuid: ''
    menuentry "Windows 11" --class windows {
      insmod part_gpt
      insmod fat
      insmod search_fs_uuid
      search --fs-uuid --set=root ${uuid}
      chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
  '';
in
{
  boot.loader.grub = {
    enable = true;

    # Disable osProber on both to keep the menu indices static
    useOSProber = lib.mkForce false;

    # Assign the correct UUID based on which machine is being built
    extraEntries =
      if isHiggs then (windowsEntry "7282-E320")
      else if isGluon then (windowsEntry "1588-A8B5")
      else "";

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS ${config.system.nixos.distroName}";
          lineBottom = "Survival Mode, No Cheats";
          imgName = "nixos";
        }
      ] ++ (if (isHiggs || isGluon) then [{
        name = "windows";
        lineTop = "Windows 11";
        lineBottom = "Hardcore Mode, All Cheats Enabled";
        imgName = "windows";
      }] else [ ]);
    };
  };
}
