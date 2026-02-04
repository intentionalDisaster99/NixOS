# Trying with google-drive-ocamlfuse

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs [
    (builtins.getFlake "github:astrada/google-drive-ocamlfuse").packages.x86_64-linux.default
  ];

    #   # services.kio-fuse.enable = true;
    #   services.gvfs.enable = true;


    }
