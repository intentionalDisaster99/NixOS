# Enables hyprland and everything that I use with hyprland (like noctalia)
# This is the Home-manager module, note that there is also a required System module, because we need to run it with UWSM

{ pkgs, hyprland, config, inputs, username, ... }:

{


  home-manager.users.${username} = {

    home.packages = with pkgs; [
      activate-linux
      kittysay
      neo-cowsay
      fortune
      sl
      pay-respects
      gping
      fireplace
      figlet
      mapscii
      nyancat
      cbonsai
      asciiquarium
      xcowsay
      pipes
      lolcat
      golazo
    ];

  };
}
