# /etc/nixos/modules/sddm/minesddm.nix

{ config, lib, pkgs, ... }:

let
  # This section defines the package for the SDDM theme.
  # It fetches the source from GitHub and prepares it for SDDM.
  minesddm-theme = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-theme-minesddm";
    version = "unstable-2024-03-24";

    src = pkgs.fetchFromGitHub {
      owner = "Davi-S";
      repo = "sddm-theme-minesddm";
      # This is the latest commit hash at the time of writing.
      rev = "d38d1fc953b0e3605a1e7b6c507a2168925232fe";
      # This is the corresponding content hash.
      sha256 = "09l3r5s720k5384y6873bby4k1ksc05r8w2r0g166p5w1p832596";
    };

    # This phase installs the theme files into the correct directory structure
    # that SDDM expects.
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/sddm/themes/minesddm
      cp -R ./* $out/share/sddm/themes/minesddm/
      runHook postInstall
    '';

    meta = with lib; {
      description = "A simple and beautiful SDDM theme inspired by Minecraft";
      homepage = "https://github.com/Davi-S/sddm-theme-minesddm";
      # The repo doesn't have a license file, so we'll mark it as unfree.
      license = licenses.unfree;
      platforms = platforms.all;
    };
  };

in
{
  # Here we define a new NixOS option to easily enable or disable the theme.
  options.services.displayManager.sddm.theme-minesddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = lib.mdDoc "Enable the MineSDDM theme.";
    };
  };

  # This part applies the configuration if the option is enabled.
  config = lib.mkIf config.services.displayManager.sddm.theme-minesddm.enable {
    # Ensure SDDM is enabled and set the theme name.
    services.displayManager.sddm = {
      enable = true;
      theme = "minesddm";
    };

    # Add the theme package to the system so SDDM can find it.
    environment.systemPackages = [ minesddm-theme ];
  };
}
