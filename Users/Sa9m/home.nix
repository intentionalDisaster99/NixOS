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
  ];

  # Everything that isn't installed here will be imported in modules, so I only have a few basic things here
  home.packages = with pkgs; [
    neovim
    networkmanager 
  ]

  # My basic git configuration which I will always want on my system
  programs.git = {
    enable = true;
    userName = "Sa9m";
    userEmail = "abyssalflerken@gmail.com";
  };

  home.stateVersion = ""


}

