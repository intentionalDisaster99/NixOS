# Currently does not work. I'll look into that soon, don't worry

{ ... }:

{

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["sa9m"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    # virtualisation.libvirtd.qemu = {
    #   package = pkgs.qemu_kvm;
    #   runAsRoot = true;
    #   swtpm.enable = true;
    #   ovmf = {
    #     enable = true;
    #     package = (pkgs.OVMFFull.override { secureBoot = true; tpmSupport = true; });
    #   };
    # };

}