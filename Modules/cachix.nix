# This is not a home-manager module, like most of my other ones. This is a nixos configuration module that will always be imported.
# It allows for me to add in cachix substitutors so that I don't have to compile everything from source all the time.

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
