{ inputs, config, pkgs, ... }:

{


  home-manager-users.${username} = {
    home.packages = with pkgs; [
      spotify
    ];

  };
}
