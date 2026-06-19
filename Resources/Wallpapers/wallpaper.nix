# Home-manager module to symlink my wallpapers folder to the one that Noctalia expects
# This is in ~/.face


{ pkgs, hyprland, config, inputs, ...}:

{

  home.file.".face" = {
    source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/Resources/Profile/profile.jpg"
  }

}