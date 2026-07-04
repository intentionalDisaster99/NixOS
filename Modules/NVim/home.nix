# It's neovim
{ config, pkgs, ... }:

{
  programs.neovim = {
    # enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      gcc
      gnumake
      unzip
      wl-clipboard
      nodejs
      tree-sitter
    ];
  };

  # Symlinking to my dots
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/NVim/Dots";

}
