#
# This is my home-manager entrypoint, so where I define my sa9m user. 
# If you are wanting to use my config, you can change your settings here (or copy this to have more users)
#


{ config, pkgs, ...}:
{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";


  imports = [
    # Empty for now, but where I will be putting all of my specific modules for my user
    ./../../Modules/fish.nix
    ./../../Modules/hyprland.nix
    ./../../Modules/nvim.nix
  ];

  # Everything that isn't installed here will be imported in modules, so I only have a few basic things here
  home.packages = with pkgs; [
    neovim
    networkmanager 
  ];

  # My basic git configuration which I will always want on my system
  programs.git = {
    enable = true;
    settings.user.name = "Sa9m";
    settings.user.email = "abyssalflerken@gmail.com";
  };

  home.stateVersion = "26.05";


}

