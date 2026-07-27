# Installs obsidian. That's it. Real simple flake

# Tempted to start using the other bracket style...
{ pkgs, hyprland, config, inputs, username, ... }: {


  home-manager.users.${username} = {

    home.packages = with pkgs; [
      obsidian
    ];

    # No dots right now, but kept this for easy access in case I get some
    # home.file.".config/pypr" = {
    #   source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Modules/Pyprland/Dots";
    # };

  };
}
