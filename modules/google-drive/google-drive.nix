{ config, pkgs, lib, ... }:

let
  # A short variable for our module's options
  cfg = config.services.google-drive-ocamlfuse;

  # Define the options for a *single* mount
  mountOptions = { name, ... }: {
    options = {
      mountPoint = lib.mkOption {
        type = lib.types.str;
        description = "Path to the mount point. %h is replaced with the user's home directory.";
        example = "%h/GoogleDrive";
      };

      label = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The label for multi-account support (e.g., 'work').";
      };

      sharedDriveId = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "The ID of the Shared Drive to mount. If null, mounts the main 'My Drive'.";
      };
    };
  };
in
{
  # 1. DEFINE THE MODULE'S OPTIONS
  options.services.google-drive-ocamlfuse = {
    enable = lib.mkEnableOption "google-drive-ocamlfuse user services";

    user = lib.mkOption {
      type = lib.types.str;
      description = "The user account to run these services under.";
      example = "sa9m";
    };

    mounts = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule mountOptions);
      default = { };
      description = "A set of Google Drive mounts to create.";
      example = ''
        {
          main = {
            mountPoint = "%h/Drive/GoogleDrive";
          };
          workShared = {
            mountPoint = "%h/Drive/Shared";
            label = "work";
            sharedDriveId = "0A...Xw";
          };
        }
      '';
    };
  };

  # 2. CONFIGURE THE SYSTEM BASED ON THE OPTIONS
  config = lib.mkIf cfg.enable {

    # Ensure the package is installed
    environment.systemPackages = [ pkgs.google-drive-ocamlfuse ];

    # Add the specified user to the 'fuse' group
    users.users.${cfg.user}.extraGroups = [ "fuse" ];

    # This part iterates over every entry in `cfg.mounts`
    # and creates a systemd service for each one.
    users.users.${cfg.user}.systemd.user.services = lib.mapAttrs'
      (name: mount:
        let
          # Build the command string, adding flags only if they are set
          execStart = ''
            ${pkgs.google-drive-ocamlfuse}/bin/google-drive-ocamlfuse \
            ${lib.optionalString (mount.label != null) "-label ${mount.label}"} \
            ${lib.optionalString (mount.sharedDriveId != null) "-shared-drive-id ${mount.sharedDriveId}"} \
            ${mount.mountPoint}
          '';
        in
        {
          # Create a unique service name, e.g., "gdfuse-main"
          name = "gdfuse-${name}";

          # Define the service
          value = {
            description = "Mount Google Drive (${name}) at ${mount.mountPoint}";
            after = [ "network-online.target" ];
            wants = [ "network-online.target" ];

            serviceConfig = {
              ExecStart = execStart;
              ExecStop = "${pkgs.fuse}/bin/fusermount -u ${mount.mountPoint}";
              Restart = "on-failure";
              RestartSec = "10s";
            };

            install = {
              wantedBy = [ "default.target" ];
            };
          };
        }
      )
      cfg.mounts;
  };
}
