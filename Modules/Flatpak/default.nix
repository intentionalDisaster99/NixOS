# Just a place ot install all of my flatpaks (some things are just nice and easy to install via flatpak)
{ users
, config
, pkgs
, inputs
, username
, ...
}:
{

  services.flatpak.enable = true;

  home-manager.users.${username} =
    { config, ... }:
    {

      services.flatpak.update.auto.enable = false;

      services.flatpak.uninstallUnmanaged = false;
      # add here the flatpaks you want to install
      services.flatpak.packages = [
        "com.stremio.stremio"
      ];

    };
}
