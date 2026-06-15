
# Enables hyprland and everything that I use with hyprland (like noctalia)

{ pkgs, hyprland, config, inputs, ...}:

{

  imports = [
    # ./noctalia.nix
  ];

  home.packages = with pkgs; [
    kitty
    xdg-desktop-portal-gtk
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    nerd-fonts.noto
  ];

  # Things that we need for Kitty (required by hyprland)
  fonts.fontconfig.enable = true;
  programs.kitty.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Enabling screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [ "hyprland" "gtk" ];
    };
  };

  # Configuration stuff goes past here
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;

    settings = {

      # I like using the super key, but modularity is always nice if I want to change later
      "$mod" = "SUPER";
      
      # All of my keybinds
       bind = [

        # Meta actions
        "$mainMod SHIFT, C, exec, pypr menu \"Color picker\""
        "$mainMod SHIFT, F, togglefloating, "
        "$mainMod CTRL, F, fullscreen, 0"

        # Opening Apps
        "$mod, B, exec, brave"
        "$mainMod, T, exec, kitty"
        "ALT, SPACE, exec, rofi -show drun" # TODO change to noctalia
        "SUPER, I, exec, code"
        "$mainMod, N, exec, obsidian"
        "$mainMod, G, exec, steam"
        "$mainMod, E, exec, dolphin"

        

        # Magic workspaces keybinds
        "$mainMod, O, exec, pypr toggle term"
        "$mainMod SHIFT, J, movetoworkspace, special:magic"
        "$mainMod SHIFT, J, movetoworkspace, special:magic"
        "SUPER, K, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk &"
        "$mainMod, S, togglespecialworkspace, spotify"
        "$mainMod, D, togglespecialworkspace, discord"
        "$mainMod, M, togglespecialworkspace, messages"



        # Utility shortcuts (more info because I forget these a lot lol)
        "$mainMod SHIFT, T, exec, Telegram"                            # Telegram to take text out of a screenshot
        "$mainMod, C, exec, hyprpicker -a"                             # Grabs a color code on the screen 
        "$mainMod SHIFT, C, exec, pypr menu "Color picker""            # Same as above, but with more options
        "$mainMod SHIFT, S, exec, grim -g "$(slurp)" - | wl-copy"      # Takes a screenshot and copies it
        "$mainMod SHIFT, E, exec, grim -g "$(slurp)" - | swappy -f - " # Same as above but with more options
        "$mainMod SHIFT, V, exec, emote"                               # A way to copy emojis
        "$mainMod, code:60 , workspace, e+1"                           # Switching workspaces on my PC
        "$mainMod, code:59 , workspace, e-1"                           # Switching workspaces on my PC
        
        # For keyboards
        ", XF86AudioLowerVolume, exec, volumectl -u down"
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioMute, exec, volumectl toggle-mute"
        ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
        ", XF86MonBrightnessUp, exec, lightctl -D intel_backlight up"
        ", XF86MonBrightnessDown, exec, lightctl -D intel_backlight down"

        # Mouse
        "bindm = $mainMod, mouse:272, movewindow"
        "bindm = $mainMod, mouse:273, resizewindow"



      ]++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)

    };

    # extraConfig = ''
    #''
  };
}
