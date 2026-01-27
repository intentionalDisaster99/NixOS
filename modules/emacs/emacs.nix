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

    # So that I can use the live latex editor
    texlive.combined.scheme-medium

    libtool
    jdt-language-server
  ];

  # Enable Nerd Fonts (Required for Doom's icons)
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];

  # Ensuring emacs is in my path if I ever need it
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_add_path $HOME/.config/emacs/bin
    '';
  };
}
