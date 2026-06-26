# Installs and enables fish as the default shell
{ users, config, pkgs, inputs, ... }:
{

  imports = [
    ./../Atuin/home.nix
    ./../Starship/home.nix
  ];

  # Including some nice things that I like for my shells, like eza and z
  home.packages = with pkgs; [
    zoxide
    eza
    bat
    fireplace
    os-prober # TODO move (this was put here in a hurry) (to a boot module perchance)
  ];

  # Symlinking to my dots
  home.file.".config/fish" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Fish/Dots";
  };

}
