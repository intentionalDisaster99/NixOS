{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.steno;
in
{
  options.programs.steno = {
    enable = mkEnableOption "stenography support via Plover";
  };

  config = mkIf cfg.enable {
    # Install the Plover package
    environment.systemPackages = with pkgs; [
      plover.dev # The dev branch often has better Wayland support
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
