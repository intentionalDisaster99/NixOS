{ users
, config
, pkgs
, inputs
, username
, ...
}:
{

  # Import the module
  imports = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home-manager.users.${username} =
    { config, ... }:
    {

      # Turning it on
      programs.noctalia-shell = {
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
