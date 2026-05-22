{ config, pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.symlinkJoin {
      name = "stremio-fixed";
      paths = [ pkgs.stremio-linux-shell ];
      postBuild = ''
        wrapProgram $out/bin/stremio-linux-shell \
          --add-flags "--no-sandbox"
      '';
    })
  ];

  networking.firewall = {
    allowedTCPPorts = [ 11470 ];
    allowedUDPPorts = [ 11470 ];
  };

  hardware.graphics = {
    enable = true;
    # enable32Bit = true;
  };
}
