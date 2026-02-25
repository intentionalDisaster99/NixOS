{ config, lib, pkgs, ... }:

let
  cfg = config.programs.steno;

  # Packaging a dependency that plover needs
  rtf_tokenize = pkgs.python3Packages.buildPythonPackage rec {
    pname = "rtf_tokenize";
    version = "1.0.0";
    format = "setuptools";

    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      # We use a fake hash here. Nix will fail the first build and tell you the real one!
      hash = "sha256-XD3zkNAEeb12N8gjv81v37Id3RuWroFUY95+HtOS1gg=";
    };

    doCheck = false;
  };

  # Inject the dependency into Plover
  patchedPlover = pkgs.plover.dev.overrideAttrs (old: {
    propagatedBuildInputs = (old.propagatedBuildInputs or [ ]) ++ [ rtf_tokenize ];
  });

in
{
  options.programs.steno = {
    enable = mkEnableOption "stenography support via Plover";
  };

  config = mkIf cfg.enable {
    # Install the Plover package
    environment.systemPackages = with pkgs; [
      patchedPlover
    ];

    # Enable uinput hardware module
    hardware.uinput.enable = true;

    # Set up udev rules to allow Plover to create a virtual keyboard
    services.udev.extraRules = ''
      # Allow access to uinput so Plover can inject translated keystrokes
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    # Add your user to the necessary groups for steno to work
    users.users.sa9m.extraGroups = [
      "input"
      "dialout"
      "uinput"
    ];
  };
}
