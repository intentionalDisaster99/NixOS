{ config, pkgs, lib, inputs, ... }:

{

  environment.systemPackages = with pkgs; [ emacs ];

  services.emacs = {
    enable = true;
    # defaultEditor = true;
  };

}
