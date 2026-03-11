{ config, pkgs, ... }:

{
  # Define the overlay to globally override the Mathematica derivation
  nixpkgs.overlays = [
    (final: prev: {
      mathematica = prev.mathematica.override {
        source = prev.requireFile {
          name = "Wolfram_14.3.0_LIN_Bndl.sh";
          sha256 = "0zgl62wmrsrsza7835sl8jri8imwvlqcb303n9qpyayspjaqhhnb";
          message = ''
            Your override for Mathematica includes a different src for the installer,
            and it is missing.
          '';
          hashMode = "recursive";
        };
      };
    })
  ];


  # Install the overlaid package
  environment.systemPackages = [
    pkgs.mathematica
  ];
}
