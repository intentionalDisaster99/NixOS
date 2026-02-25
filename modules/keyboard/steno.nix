# Trying to set up plover for stenography

{ inputs, pkgs, ... }: {

  users.users."sa9m".extraGroups = [ "input" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';

  # Some home manager definitions 
  home-manager.users."sa9m" = {
    imports = [
      inputs.plover-flake.homeManagerModules.plover
    ];

    programs.plover = {
      enable = true;

      # If I only want some specific plugins
      # package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover.withPlugins (
      #   ps: with ps; [
      #     plover-lapwing-aio
      #   ]
      # );

      # Or, use `plover-full` if you want Plover with all the plugins installed:
      package = inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover-full;

      settings = {
        "Machine Configuration" = {
          # I don't have a machine lol
          # machine_type = "Gemini PR";
          auto_start = true;
        };
        # Pointing to the actual keyboard itself
        "Evdev Machine Configuration" = {
          devices = ''["/dev/input/by-path/platform-i8042-serio-0-event-kbd"]'';
        };
        "Output Configuration".undo_levels = 100;
      };
    };
  };

  systemd.user.services.plover = {
    description = "Plover stenography engine";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      # Explicitly use the plover-full package from your flake inputs!
      ExecStart = "${inputs.plover-flake.packages.${pkgs.stdenv.hostPlatform.system}.plover-full}/bin/plover -g none";
      Restart = "on-failure";
      Environment = "PATH=${pkgs.coreutils}/bin";
    };
  };

}
