# A way to automatically trigger shells
{ config, pkgs, username, ... }:
{

  # Defining with home-manager
  home-manager.users.${username} = {

    # I don't know if you actually need both, but it works currently and I don't want to bother testing lol
    home.packages = with pkgs; [ nix-direnv direnv ];

    programs.direnv.nix-direnv.enable = true;

  };

}
