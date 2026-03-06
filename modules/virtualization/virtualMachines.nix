{ config, pkgs, lib, ... }:

{
  programs.virt-manager.enable = true;

  users.users.sa9m.extraGroups = [ "libvirtd" ];

  virtualisation = {
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        # No ovmf block needed anymore!
      };
    };
  };
}
