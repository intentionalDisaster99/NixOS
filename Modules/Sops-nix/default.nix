# Handles secrets safely

{ pkgs, hyprland, config, inputs, username, ... }:

{

  # TODO set this up (nevermind then, I guess I didn't have it set up )

  home-manager-users.${username} = {
    home.packages = with pkgs; [
    ];





  }
