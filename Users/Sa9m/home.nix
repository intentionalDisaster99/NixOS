#
# This is my home-manager entrypoint, so where I define my sa9m user. 
# If you are wanting to use my config, you can change your settings here (or copy this to have more users)
#


{ config, pkgs, inputs, ...}:
{
  home.username = "sa9m";
  home.homeDirectory = "/home/sa9m";


  imports = [

    # All of the program home manageing
    ./../../Modules/Fish/home.nix
    ./../../Modules/Hyprland/home.nix
    # ./../../Modules/nvim.nix # Removed till updating

    # Resource movement
    ./../../Resources/Profile/profile.nix
    ./../../Resources/Wallpaper/wallpaper.nix
  ];

  # Everything that isn't installed here will be imported in modules, so I only have a few basic things here
  home.packages = with pkgs; [
    brave 
    vscode
    kdePackages.dolphin # TODO move to a better place
  ];

  # My basic git configuration which I will always want on my system
  programs.git = {
    enable = true;
    settings.user.name = "Sa9m";
    settings.user.email = "abyssalflerken@gmail.com";
  };

  home.stateVersion = "26.05";


}

