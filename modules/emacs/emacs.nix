{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    emacs # Or emacs29 / emacs-unstable for newer features
    fd # faster 'find' alternative, required by Doom
    coreutils # basic GNU utilities
    clang # often needed for compiling Emacs packages

    # Optional: Language servers you might want later
    # nil  # Nix Language Server
    # zls  # Zig Language Server
  ];

  # Enable Nerd Fonts (Required for Doom's icons)
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];
}
