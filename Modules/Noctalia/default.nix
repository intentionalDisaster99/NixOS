{ users, config, pkgs, inputs, username, ... }:

{

  programs.noctalia-shell = {
    enable = true;
  };


  home-manager.users.${username} = {

    home.packages = with pkgs; [
      noctalia-shell
      evtest
    ];

    # Symlinking to my dots
    home.file.".config/noctalia" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
    };

  };
}
