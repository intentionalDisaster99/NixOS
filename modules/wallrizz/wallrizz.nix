{ config, lib, pkgs, ... }:

let
  cfg = config.programs.wallrizz;

  # Our custom WallRizz derivation
  wallrizzPkg = pkgs.stdenv.mkDerivation rec {
    pname = "wallrizz";
    version = "1.1.0"; # Update this to the latest release version

    src = pkgs.fetchurl {
      url = "https://github.com/5hubham5ingh/WallRizz/releases/download/v${version}/WallRizz-linux-amd64";
      # Remember to update this hash! Run `nix-prefetch-url <url>` to get the correct one.
      sha256 = pkgs.lib.fakeSha256;
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
    # 1. Install the package
    home.packages = [ cfg.package ];

    # 2. Declaratively map the extension scripts to the ~/.config/WallRizz directory
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
