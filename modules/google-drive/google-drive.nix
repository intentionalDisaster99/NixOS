{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [

    # ...
    # You can build it from source if you want
    # (builtins.getFlake "github:astrada/google-drive-ocamlfuse").packages.x86_64-linux.default

    google-drive-ocamlfuse
  ];


  #   environment.systemPackages = with pkgs; [
  #     (builtins.getFlake "github:astrada/google-drive-ocamlfuse").packages.x86_64-linux.default
  #   ];

  # services.hardware.openrgb.enable = true;
  #   services.hardware.openrgb = {
  #     enable = true;
  #     package = pkgs.openrgb-with-all-plugins;
  #     motherboard = "amd";
  #   };


}
