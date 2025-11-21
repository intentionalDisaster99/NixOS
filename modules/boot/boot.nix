# Controls the bootloader that I use (Grub)

{ config, pkgs, lib, inputs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.extraEntries = ''
      menuentry 'Windows Boot Manager (on /dev/nvme0n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-7282-E320' {
    insmod part_gpt
    insmod fat
    search --no-floppy --fs-uuid --set=root 7282-E320
    chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    }
      
    menuentry 'Arch Linux (on /dev/nvme0n1p6)' --class arch --class gnu-linux --class gnu --class os $menuentry_id_option 'osprober-gnulinux-simple-edc2422e-b5ee-48f7-a0e7-b17f7b05e9d0' {
    insmod part_gpt
    insmod fat
    search --no-floppy --fs-uuid --set=root 7282-E320
    linux //kernels/0494yc5krhmsrp4vcrlbp1r5fnx6cflf-linux-6.12.44-bzImage init=/nix/store/iswxw6pn34jfmmfh9yc04y7wzi7cdzfn-nixos-system-higgs-boson-25.11.20250830.d7600c7/init loglevel=4 lsm=landlock,yama,bpf
    initrd //kernels/bww4s0s751r2xlmhlin5zzisj5ahqrkm-initrd-linux-6.12.44-initrd
    }

  '';
  # Takes absolute ages so commented for now 
  boot.loader.grub.useOSProber = false;

  # Teehee silly sddm
  services.displayManager.sddm = {
    enable = true;
    theme = "minesddm";
    wayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # Add the theme package itself
    inputs.minesddm.packages.${pkgs.system}.default

    # Add the required Qt dependencies
    qt5.qtbase
    qt5.qtquickcontrols2
    qt5.qtgraphicaleffects
  ];


}
