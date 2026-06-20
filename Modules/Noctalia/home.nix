# A nice shell/bar that I can use (it has a crap ton of stuff builtin and is just overall really nice to use)

{ inputs, config, pkgs, ...}:

{

home.packages = with pkgs; [
  noctalia-shell
];

# I guess this isn't needed?
programs.noctalia = {
  enable = true;
};

}