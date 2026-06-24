# Installs and enables fish as the default shell
{ users, config, pkgs, inputs, ... }:
{

  imports = [
    ./../Atuin/home.nix
    ./../Starship/home.nix
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      # cd = "z";
      # ls = "eza";
      nrs = "/etc/nixos/Scripts/nrs.sh";
    };

  };

  # Including some nice things that I like for my shells, like eza and z
  home.packages = with pkgs; [
    zoxide
    eza
  ];

  # Symlinking to my dots
  home.file.".config/fish" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Fish/Dots";
  };

}
