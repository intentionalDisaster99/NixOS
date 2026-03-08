{ config, pkgs, ... }:

let
  # Detect if we are on the laptop
  isHiggs = config.networking.hostName == "higgs-boson";
in
{
  boot.loader.grub = {
    enable = true;

    # Only disable osProber on higgs-boson to speed up rebuilds
    useOSProber = if isHiggs then false else true;

    # Manually add the Windows entry ONLY for higgs-boson
    extraEntries =
      if isHiggs then ''
        menuentry "Windows 11 (Fast Boot)" {
          insmod part_gpt
          insmod fat
          insmod search_fs_uuid
          # Update this UUID with the one from your laptop's EFI partition
          search --fs-uuid --set=root 7282-E320 
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
        }
      '' else "";

    minegrub-world-sel = {
      enable = true;
      customIcons = [
        {
          name = "nixos";
          lineTop = "NixOS ${config.system.nixos.distroName}";
          lineBottom = "Survival Mode, No Cheats, Version: ${config.system.nixos.release}";
          imgName = "nixos";
        }
        # Add a custom icon for the Windows entry on Higgs
        (if isHiggs then {
          name = "windows";
          lineTop = "Windows 11";
          lineBottom = "Hardcore Mode, All Cheats Enabled";
          imgName = "windows";
        } else { })
      ];
    };
  };
}
