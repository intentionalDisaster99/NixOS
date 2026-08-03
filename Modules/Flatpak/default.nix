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

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  home-manager.users.${username} =
    { config, ... }:
    {
      # add here the flatpaks you want to install
      services.flatpak.packages = [
        "com.stremio.stremio"
      ];

    };
}

