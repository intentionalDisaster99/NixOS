{ config, lib, pkgs, ... }:

let
  cfg = config.programs.wallrizz;

  # Custom WallRizz derivation
  wallrizzPkg = pkgs.stdenv.mkDerivation rec {
    pname = "wallrizz";
    version = "1.4.0";

    src = pkgs.fetchurl {
      url = "https://github.com/5hubham5ingh/WallRizz/releases/download/v${version}/WallRizz-linux-x86_64";
      sha256 = "sha256-P8HllDD3bEX0rIGEMqiNFCd7+I9uJowaSCFf/u/u1vk=";
    };

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/wallrizz
      chmod +x $out/bin/wallrizz
    '';
  };

in
{
  options.programs.wallrizz = {
    enable = lib.mkEnableOption "WallRizz terminal-based wallpaper and system theme manager";

    package = lib.mkOption {
      type = lib.types.package;
      default = wallrizzPkg;
      description = "The WallRizz package to install.";
    };

    extensionScripts = lib.mkOption {
      type = lib.types.attrsOf lib.types.lines;
      default = { };
      example = {
        "waybar.sh" = ''
          # Script content here
        '';
      };
      description = "Scripts to place in ~/.config/WallRizz/themeExtensionScripts/ to be executed on theme changes.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = lib.mapAttrs'
      (name: content:
        lib.nameValuePair "WallRizz/themeExtensionScripts/${name}" {
          text = content;
          executable = true;
        }
      )
      cfg.extensionScripts;
  };
}
