{ users
, config
, pkgs
, inputs
, username
, ...
}:
{

  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };
  home-manager.users.${username} =
    { config, ... }:
    {

      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;

        # For some reason, this was failing, so I had to add in libsndfile manually
        package =
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
            (oldAttrs: {
              buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ pkgs.libsndfile ];
            });
      };

      # Symlinking to my dots
      home.file.".config/noctalia" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
      };

    };
}
