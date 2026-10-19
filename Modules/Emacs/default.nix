# Installs emacs so that I can play with it (I might end up using it for notes? idk yet)
{ users
, config
, pkgs
, inputs
, username
, ...
}:
{
  # imports = [
  # ];

  home-manager.users.${username} =
    { config, ... }:
    {

      # Installing the bits I need
      home.packages = with pkgs; [
        # required dependencies
        git
        emacs # Emacs 27.2
        ripgrep
        # optional dependencies
        coreutils # basic GNU utilities
        fd
        #
        # clang
        ispell
        asm-lsp
        (texlive.combine {
          inherit (texlive)
            scheme-small
            dvisvgm
            preview
            dvipng
            cm-super
            type1cm
            ;
        })

        # ARM stuff
        pkgs.asm-lsp # language server
        # aarch64.gcc # aarch64-unknown-linux-gnu-{as,gcc,ld,objdump,...}
        # aarch64.gdb # aarch64-unknown-linux-gnu-gdb
        pkgs.qemu # qemu-aarch64 for running binaries
        pkgs.gnumake

      ];

      services.emacs = {
        enable = true;
        defaultEditor = true;
      };

      # Symlinking to my dots
      # home.file.".config/doom" = {
      # xdg.configFile.".emacs.d".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Dots";
      home.file.".emacs.d" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Dots";
      };
    };

}
