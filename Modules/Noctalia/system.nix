{ users, config, pkgs, inputs, ... }:

{

  # Literally the only reason I needed this
  programs.noctalia-shell = {
    enable = true;
  };

  # Symlinking to my dots
  home.file.".config/noctalia" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Noctalia/Dots";
  };


}
