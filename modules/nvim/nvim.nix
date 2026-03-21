# I was dumb and this should actually be in home.nix
# So this should not actually be included in the configuration
{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
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

}
