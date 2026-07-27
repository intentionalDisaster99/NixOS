# Home-manager module to symlink my wallpapers folder to the one that Noctalia expects
# This is in ~/.face
{ pkgs, hyprland, config, inputs, username, ... }: {

  home-manager-users.${username} = {
    home.file.".config/wallpapers" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Resources/Wallpaper/Wallpapers";
    };
  };

}
