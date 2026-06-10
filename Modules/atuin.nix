
# A better history thingy

{ config, pkgs, ... }:

{
  # Install atuin package to system and add to path.
  home.packages = with pkgs; [ atuin ];

  services.atuin = {
    enable = true;
  };

  programs.bash = {
    interactiveShellInit = ''
      eval "atuin init fish | source"
    '';

  };
}
