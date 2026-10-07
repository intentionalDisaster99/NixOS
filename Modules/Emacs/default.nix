# Installs emacs so that I can play with it (I might end up using it for notes? idk yet)
{ users
, config
, pkgs
, inputs
, username
, ...
}:
{
  # imports = [
  # ];

  home-manager.users.${username} =
    { config, ... }:
    {

      # Installing the bits I need
      home.packages = with pkgs; [
        emacs
      ];

      services.emacs = {
        enable = true;
        defaultEditor = true;
      };

      # Symlinking to my dots
      home.file.".config/emacs" = {
        source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Dots";
      };

    };

}
