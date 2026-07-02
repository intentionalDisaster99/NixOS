# Installs and enables KDE connect so that I can connect with my phone
{ users, config, pkgs, inputs, ... }:
{

  # To connect to ma phone
  programs.kdeconnect = {
    enable = true;
  };

}
