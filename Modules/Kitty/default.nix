# The shell that hyprland uses so the one that I also use

{ inputs, config, pkgs, username, ... }:

{

  home-manager.users.${username} = { config, ... }: {
    home.packages = with pkgs; [
      kitty
    ];

    # Symlinking to my dots (apparently xdg.configFile is better than raw symlink for some reason)
    xdg.configFile."kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Kitty/Dots/kitty.conf";

  };

  # If you wanted to use home-manager to generate dots, but I want to use my own
  # programs.kitty = {
  #   enable = true;
  #
  #   # Enable native Fish integration
  #   shellIntegration.enableFishIntegration = true;
  #
  #   # # Explicitly set the shell Kitty should launch
  #   settings = {
  #     shell = "${pkgs.fish}/bin/fish";
  #   };
  # };

}
