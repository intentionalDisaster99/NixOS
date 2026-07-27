# Enables starship and everything that I use with hyprland (like noctalia)

{ pkgs, hyprland, config, inputs, username, ... }:

{

  home-manager.users.${username} = { config, ... }: {
    programs.starship = {
      enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      starship
    ];


    # Symlinking to my dots
    home.file.".config/starship.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Starship/Dots/starship.toml";
    };

  };
}
