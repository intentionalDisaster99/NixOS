{ config
, pkgs
, lib
, ...
}:

let
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
          lineBottom = "The right choice";
          imgName = "nixos";
        }
      ]
      ++ (
        if (activeUuid != null) then
          [
            {
              name = "windows";
              lineTop = "Windows 11";
              lineBottom = "Why. Just why.";
              imgName = "windows";
            }
          ]
        else
          [ ]
      );
    };
  };
}
