# A better history thingy

{ config, pkgs, username, ... }:

{

  # Defining with home-manager
  home-manager.users.${username} = {

    # Install atuin package to system and add to path.
    home.packages = with pkgs; [ atuin ];

    # I didn't bother with raw dots because it is such a simple program(configure-wise I mean)
    programs.atuin = {
      enable = true;
      settings = {
        auto_sync = true;
        sync_frequency = "5m";
        i
          sync_address = "https://api.atuin.sh";
        search_mode = "fuzzy";
      };
    };

  };

}
