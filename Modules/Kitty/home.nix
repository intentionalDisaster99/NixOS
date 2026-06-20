# The shell that hyprland uses so the one that I also use

{ inputs, config, pkgs, ... }:

{

  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty = {
    enable = true;

    # Enable native Fish integration
    shellIntegration.enableFishIntegration = true;

    # # Explicitly set the shell Kitty should launch
    settings = {
      shell = "${pkgs.fish}/bin/fish";
    };
  };

}
