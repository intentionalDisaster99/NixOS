# /etc/nixos/modules/sddm/minesddm.nix

{ config, lib, pkgs, ... }:

let
  minesddm-theme = pkgs.stdenv.mkDerivation rec {
    pname = "sddm-theme-minesddm";
    version = "unstable-2024-05-13";

    src = pkgs.fetchFromGitHub {
      # UPDATED: Pointing to the new owner and repo
      owner = "keyitdev";
      repo = "sddm-theme-minesddm";
      # UPDATED: New commit hash from the active repo
      rev = "3b0d24c088c42289f0da64a0210e7ca85387d853";
      # UPDATED: New content hash
      sha256 = "1p6l91v4h165q8j5h0v2y76h7g1w20b2z6y314p57d47s2c41p7m";
    };

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/sddm/themes/minesddm
      cp -R ./* $out/share/sddm/themes/minesddm/
      runHook postInstall
    '';

    meta = with lib; {
      description = "A simple and beautiful SDDM theme inspired by Minecraft";
      homepage = "https://github.com/keyitdev/sddm-theme-minesddm";
      # UPDATED: The new repo has a proper license file
      license = licenses.gpl3Only;
      platforms = platforms.all;
    };
  };

in
{
  options.services.displayManager.sddm.theme-minesddm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = lib.mdDoc "Enable the MineSDDM theme.";
    };
  };

  config = lib.mkIf config.services.displayManager.sddm.theme-minesddm.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "minesddm";
    };
    environment.systemPackages = [ minesddm-theme ];
  };
}
