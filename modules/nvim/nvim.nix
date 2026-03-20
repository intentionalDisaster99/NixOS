{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      gcc # Required for Treesitter to compile parsers
      gnumake
      unzip
      wl-clipboard # For clipboard support  

      # You can also add specific LSPs or formatters here later
      # nodejs_20 
    ];
  };

  # Symlink the NvChad config from your dotfiles repository
  xdg.configFile."nvim".source = ../dotfiles/nvim;
}
