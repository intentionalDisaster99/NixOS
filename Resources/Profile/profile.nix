# Home-manager module to symlink my profile stuff to the places they are expected 
{ pkgs, hyprland, config, inputs, username, ... }: {

  home-manager.users.${username} = { config, ... }: {
    home.file.".face" = {
      source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Resources/Profile/profile.jpg";
    };
  };

}
