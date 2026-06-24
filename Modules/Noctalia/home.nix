# A nice shell/bar that I can use (it has a crap ton of stuff builtin and is just overall really nice to use)

{ inputs, config, pkgs, ... }:

{

  home.packages = with pkgs; [
    noctalia-shell
    evtest
  ];

  programs.noctalia-shell = {
    enable = true;
  };

  # Symlinking to my dots
  home.file.".config/noctalia" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
  };


}
