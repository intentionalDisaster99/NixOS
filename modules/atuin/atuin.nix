{ config, pkgs, ... }:

{
  # Install atuin package to system and add to path.
  environment.systemPackages = with pkgs; [ atuin ];

  services.atuin = {
    enable = true;
  };

  programs.bash = {
    interactiveShellInit = ''
      eval "$(atuin init bash)"
    '';
  };
}
