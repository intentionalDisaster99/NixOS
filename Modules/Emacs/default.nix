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
        # required dependencies
        git
        emacs # Emacs 27.2
        ripgrep
        # optional dependencies
        coreutils # basic GNU utilities
        fd
        #
        # clang
      ];

      services.emacs = {
        enable = true;
        defaultEditor = true;
      };

      # Symlinking to my dots
      # home.file.".config/doom" = {
      xdg.configFile."emacs".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Dots";
      # home.file.".doom.d" = {
      #   source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Emacs/Dots";
      # };

    };

}
