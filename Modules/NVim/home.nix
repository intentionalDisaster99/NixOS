# It's neovim
{ config, pkgs, ... }:

{


  home.packages = with pkgs; [
    neovim
    ripgrep
    lazygit
    fd
    gcc
    gnumake
    unzip
    wl-clipboard
    nodejs
    tree-sitter
    statix
  ];


  # Symlinking to my dots
  # I am currently just using lazyvim with minimal changes 
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/NVim/Dots";

}
