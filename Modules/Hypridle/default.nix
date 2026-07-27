# Installs and enables hypridle so that my laptop actually turns off lol
{ users, config, pkgs, inputs, ... }:
{

  home-manager-users.${username} = {
    services.hypridle.enable = true;

    home.packages = with pkgs; [
      hypridle
    ];

    # Symlinking to my dots
    home.file.".config/hypr/hypridle.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Hypridle/Dots/hypridle.conf";
    };
  };
}
