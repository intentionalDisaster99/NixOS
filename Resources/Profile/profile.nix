# Home-manager module to symlink my profile stuff to the places they are expected 


{ pkgs, hyprland, config, inputs, ... }:

{

  home.file.".face" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Resources/Profile/profile.jpg";
  };

}
