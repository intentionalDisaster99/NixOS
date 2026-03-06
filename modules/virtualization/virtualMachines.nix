{ config, pkgs, lib, ... }:

{
  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Add your user to the libvirtd group 
  # (Using users.users.<name>.extraGroups is the standard NixOS convention)
  users.users.sa9m.extraGroups = [ "libvirtd" ];

  virtualisation = {
    # Enable USB redirection for Spice
    spiceUSBRedirection.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          # 'packages' expects a list. OVMFFull.fd contains both TPM and Secure Boot support natively.
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };
}
