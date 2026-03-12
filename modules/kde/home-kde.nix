{ inputs, pkgs, ... }:

{
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
    };

    # App Lauunching global shortcuts
    hotkeys.commands = {
      launch-terminal = {
        key = "Meta+T";
        command = "kitty";
      };
      launch-browser = {
        key = "Meta+B";
        command = "brave --password-store=gnome";
      };
      launch-vscode = {
        key = "Meta+I";
        command = "code";
      };
      launch-filemanager = {
        key = "Meta+E";
        command = "dolphin";
      };
      launch-obsidian = {
        key = "Meta+N";
        command = "obsidian";
      };
      launch-app-launcher = {
        key = "Alt+Space";
        command = "rofi -show drun";
      };

      # More global shortcuts, tho these are for specific fish scripts
      toggle-vpn = {
        key = "Meta+U";
        command = "fish -c wgnord_toggle";
      };
      toggle-steno = {
        key = "Meta+Space";
        command = "fish -c steno_toggle";
      };
      toggle-powersave = {
        key = "Meta+P";
        command = "fish -c power_save_toggle";
      };
      toggle-wallpaper = {
        key = "Meta+W";
        command = "fish -c wall_toggle";
      };

      # Utility shortcuts
      open-emote = {
        key = "Meta+Shift+V";
        command = "emote";
      };
      custom-screenshot = {
        key = "Meta+Shift+S";
        command = "grim -g \"$(slurp)\" - | wl-copy";
        # Note: KDE has an excellent built-in tool called Spectacle. 
        # If grim/slurp behave strangely on KWin, change this command to "spectacle -rc"
      };
    };

    # Map your window management (KWin) actions here
    shortcuts = {
      "kwin" = {
        "Window Close" = "Meta+Shift+Q";
        "Window Fullscreen" = "Meta+Ctrl+F";
        "Window Maximize" = "Meta+M";
        "Window Minimize" = "Meta+Shift+J";

        # Focus movement (Vim bindings)
        "Window Left" = "Meta+H";
        "Window Right" = "Meta+L";
        "Window Up" = "Meta+K";
        "Window Down" = "Meta+J";

        # Window movement
        "Window Move Left" = "Meta+Shift+H";
        "Window Move Right" = "Meta+Shift+L";
        "Window Move Up" = "Meta+Shift+K";
        "Window Move Down" = "Meta+Shift+J";
      };
    };
  };
}
