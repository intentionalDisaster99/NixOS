{ config, pkgs, ... }:

let
  stremio-fixed = pkgs.stremio-linux-shell.overrideAttrs (oldAttrs: {
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
    postInstall = (oldAttrs.postInstall or "") + ''
      wrapProgram $out/bin/stremio-linux-shell \
        --add-flags "--no-sandbox"
    '';
  });
in
{
  environment.systemPackages = [
    stremio-fixed
  ];

  networking.firewall = {
    allowedTCPPorts = [ 11470 ];
    allowedUDPPorts = [ 11470 ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
