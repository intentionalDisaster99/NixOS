# I was dumb and this should actually be in home.nix
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
    ];
  };

}
