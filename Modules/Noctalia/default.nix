{ users, config, pkgs, inputs, username, ... }: {



  home-manager.users.${username} = { config, ... }: {

    # Import the home manager module
    imports = [
      inputs.noctalia.homeModules.default
    ];

    # Turning it on
    programs.noctalia = {
      enable = true;
    };


    home.packages = with pkgs; [
      evtest
    ];

    # Symlinking to my dots
    home.file.".config/noctalia" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
    };

  };
}
