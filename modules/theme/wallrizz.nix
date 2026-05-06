{ config, lib, pkgs, ... }:

let
  cfg = config.programs.wallrizz;

  # Custom WallRizz derivation
  wallrizzPkg = pkgs.stdenv.mkDerivation rec {
    pname = "wallrizz";
    version = "1.4.0";

    src = pkgs.fetchurl {
      url = "https://github.com/5hubham5ingh/WallRizz/releases/download/v${version}/WallRizz-linux-86_64.tar.gz";
      sha256 = "sha256-qBwd6yN8m1YKCVCma81UZFxQ2//ymk/ZRFNHigAnKBk=";
    };

    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = [ pkgs.stdenv.cc.cc.lib ];

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      tar -xzf $src -C $out/bin/
      mv $out/bin/WallRizz* $out/bin/wallrizz
      chmod +x $out/bin/wallrizz
      wrapProgram $out/bin/wallrizz \
        --add-flags "-d /etc/nixos/resources/wallpapers/"
    '';
  };

in
{
  options.programs.wallrizz = {
    enable = lib.mkEnableOption "WallRizz terminal-based wallpaper and system theme manager";

    scriptSource = lib.mkOption {
      type = lib.types.path;
      description = "Path to the directory in your dotfiles containing your WallRizz extension scripts.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ wallrizzPkg ];

    # Symlinking to ~/.config/WallRizz/themeExtensionScripts/
    xdg.configFile."WallRizz/themeExtensionScripts".source = cfg.scriptSource;
  };
}
