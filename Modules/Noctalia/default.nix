{ users
, config
, pkgs
, inputs
, username
, ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {

      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;

        # Symlinking to my dots
        home.file.".config/noctalia" = {
          source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
        };

      };
    };
}
