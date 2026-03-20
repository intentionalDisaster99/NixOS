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
