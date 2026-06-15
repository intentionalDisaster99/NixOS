
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
      "$mainMod" = "SUPER";

      monitor = [
        "eDP-1, preferred, auto, 1"
        "DP-1, preferred, 0x0 , 1"
        "HDMI-A-1, preferred, auto-right, 1"
        "DP-3, preferred, auto-left, 1"
        ", preferred, auto, 1, mirror, eDP-1"
        "HEADLESS-1, 1920x1080@60, 0x0, 1"
      ];

      exec-once = [
        "fish -c autostart"
        "kded6"
        "kiod6"
        "gsettings set org.freedesktop.appearance color-scheme 1"
        "gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'"
        "noctalia-shell"
      ];

      env = [
        "QT_QPA_PLATFORMTHEME,kde"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "HYPRCURSOR_THEME,breeze_cursors"
        "HYPRCURSOR_SIZE,24"
        "XCURSOR_THEME,breeze_cursors"
        "XCURSOR_SIZE,24"
        "XDG_MENU_PREFIX,plasma-"
        "XDG_SESSION_TYPE,wayland"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      # source = [
      #   "~/.config/hypr/gruvbox.conf"
      #   "~/.config/hypr/hyprvim/init.conf"
      #   "host-specific/auto.conf"
      # ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap-and-drag = true;
        };
        sensitivity = 0;
      };

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "$yellow";
        "col.inactive_border" = "$surface1";
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        blur = {
          size = 8;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 15;
          render_power = 3;
          offset = "0, 0";
          color = "$yellow";
          color_inactive = "0xff$baseAlpha";
        };
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 2, myBezier"
          "windowsOut, 1, 2, default, popin 80%"
          "border, 1, 3, default"
          "fade, 1, 2, default"
          "workspaces, 1, 1, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        force_split = 2;
      };

      master = {
        new_status = "master";
      };

      gesture = "3, horizontal, workspace";

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        background_color = "0x24273a";
      };

      binds = {
        workspace_back_and_forth = true;
      };

      device = [
        {
          name = "epic mouse V1";
          sensitivity = -0.5;
        }
      ];

      workspace = [
        "special:discord, on-created-empty:discord"
        "special:spotify, on-created-empty:uwsm app -- spotify"
        "special:messages, on-created-empty:brave --new-window https://messages.google.com/web/u/1/conversations"
      ];

      bind = [
        # Launchers & Special Apps
        "$mainMod, T, exec, kitty"
        "ALT, SPACE, exec, rofi -show drun"
        "$mainMod, B, exec, brave --password-store=gnome"
        "SUPER, I, exec, code"
        "$mainMod, E, exec, dolphin"
        "$mainMod, N, exec, obsidian"
        "$mainMod, G, exec, steam"
        "$mainMod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mainMod SHIFT, T, exec, grim -g \"$(slurp)\" - | tesseract - - | wl-copy"
        "$mainMod SHIFT, E, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mainMod SHIFT, V, exec, emote"
        "$mainMod SHIFT, W, exec, kitty --class wallrizz -e fish -l -c \"wallrizz\""
        
        # Fish Script Binds
        "$mainMod, W, exec, fish -c wall_toggle"
        "$mainMod, U, exec, fish -c wgnord_toggle"
        "$mainMod, SPACE, exec, fish -c steno_toggle"
        "$mainMod, P, exec, fish -c power_save_toggle"
        "$mainMod SHIFT, l, exec, fish -c wlogout_uniqe"
        
        # System & Toggles
        "$mainMod, L, exec, hyprlock"
        "$mainMod, C, exec, hyprpicker -a"
        "$mainMod SHIFT, N, exec, dunstctl set-paused toggle"
        "$mainMod SHIFT, Q, killactive"
        "$mainMod SHIFT, F, togglefloating,"
        "$mainMod CTRL, F, fullscreen, 0"
        "$mainMod SHIFT, P, pseudo,"
        "$mainMod SHIFT, O, togglesplit,"

        # Scratchpads / Pyprland
        "$mainMod, O, exec, pypr toggle term"
        "$mainMod, V, exec, fish -c clipboard_to_type"
        "$mainMod CTRL, V, exec, pypr toggle volume"
        "$mainMod CTRL, E, exec, pypr expose"
        "$mainMod, Z, exec, pypr zoom"
        "$mainMod SHIFT, C, exec, pypr menu \"Color picker\""

        # Special Workspaces
        "$mainMod SHIFT, J, movetoworkspace, special:magic"
        "$mainMod, J, togglespecialworkspace, magic"
        "SUPER, K, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk &"
        "$mainMod, S, togglespecialworkspace, spotify"
        "$mainMod, D, togglespecialworkspace, discord"
        "$mainMod, M, togglespecialworkspace, messages"

        # Media Controls
        "$mainMod CTRL, p, exec, playerctl play-pause"
        "$mainMod, bracketright, exec, playerctl next"
        "$mainMod, bracketleft, exec, playerctl previous"
        ", XF86AudioRaiseVolume, exec, volumectl -u up"
        ", XF86AudioLowerVolume, exec, volumectl -u down"
        ", XF86AudioMute, exec, volumectl toggle-mute"
        ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
        ", XF86MonBrightnessUp, exec, lightctl -D intel_backlight up"
        ", XF86MonBrightnessDown, exec, lightctl -D intel_backlight down"

        # Focus Movement
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, Tab, cyclenext,"
        "$mainMod, Tab, bringactivetotop,"

        # Workspaces (hyprsplit plugin commands)
        "$mainMod, 1, split:workspace, 1"
        "$mainMod, 2, split:workspace, 2"
        "$mainMod, 3, split:workspace, 3"
        "$mainMod, 4, split:workspace, 4"
        "$mainMod, 5, split:workspace, 5"
        "$mainMod, 6, split:workspace, 6"
        "$mainMod, 7, split:workspace, 7"
        "$mainMod, 8, split:workspace, 8"
        "$mainMod, 9, split:workspace, 9"
        "$mainMod, 0, split:workspace, 10"

        "$mainMod SHIFT, 1, split:movetoworkspace, 1"
        "$mainMod SHIFT, 2, split:movetoworkspace, 2"
        "$mainMod SHIFT, 3, split:movetoworkspace, 3"
        "$mainMod SHIFT, 4, split:movetoworkspace, 4"
        "$mainMod SHIFT, 5, split:movetoworkspace, 5"
        "$mainMod SHIFT, 6, split:movetoworkspace, 6"
        "$mainMod SHIFT, 7, split:movetoworkspace, 7"
        "$mainMod SHIFT, 8, split:movetoworkspace, 8"
        "$mainMod SHIFT, 9, split:movetoworkspace, 9"
        "$mainMod SHIFT, 0, split:movetoworkspace, 10"

        # Scroll Workspaces
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, code:60 , workspace, e+1"
        "$mainMod, code:59 , workspace, e-1"
        "$mainMod, code:61 , workspace, empty"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };

    # extraConfig = ''
    #   # -----------------------------------------------------
    #   # Plugins
    #   # -----------------------------------------------------
    #   plugin = /etc/hyprland/plugins/hyprsplit.so
    #   plugin {
    #       hyprsplit {
    #           num_workspaces = 10
    #           persistent_workspaces = true
    #       }
    #   }
    #
    #   # -----------------------------------------------------
    #   # Submaps
    #   # -----------------------------------------------------
    #   # Resize Submap
    #   bind = $mainMod ALT, R, submap, resize
    #   submap = resize
    #   binde = , right, resizeactive, 10 0
    #   binde = , left, resizeactive, -10 0
    #   binde = , up, resizeactive, 0 -10
    #   binde = , down, resizeactive, 0 10
    #   binde = , l, resizeactive, 10 0
    #   binde = , h, resizeactive, -10 0
    #   binde = , k, resizeactive, 0 -10
    #   binde = , j, resizeactive, 0 10
    #   bind = , escape, submap, reset 
    #   submap = reset
    #
    #   # Move Submap
    #   bind = $mainMod ALT, M, submap, move
    #   submap = move
    #   bind = , right, movewindow, r
    #   bind = , left, movewindow, l
    #   bind = , up, movewindow, u
    #   bind = , down, movewindow, d
    #   bind = , l, movewindow, r
    #   bind = , h, movewindow, l
    #   bind = , k, movewindow, u
    #   bind = , j, movewindow, d
    #   bind = , escape, submap, reset 
    #   submap = reset
    #
    #   # -----------------------------------------------------
    #   # Window & Layer Rules (V3 Syntax preserved)
    #   # -----------------------------------------------------
    #   layerrule {
    #       name = logout_blur
    #       match:namespace = logout_dialog
    #       blur = on
    #   }
    #
    #   windowrule {
    #       name = mpv_media
    #       match:title = .*mpv$
    #       float = on
    #       opaque = on
    #       size = 50% 50%
    #   }
    #
    #   windowrule {
    #       name = wallrizz
    #       match:class = wallrizz
    #       float = on
    #       opaque = on
    #       size = 70% 50%
    #   }
    #
    #   windowrule {
    #       name = Board_Game_Search_Project
    #       match:class = MeepMeep
    #       float = on
    #       opaque = on
    #       size = 50% 50%
    #   }
    #
    #   windowrule {
    #       name = video_media
    #       match:content = video
    #       float = on
    #       opaque = on
    #       size = 50% 50%
    #   }
    #
    #   windowrule {
    #       name = imv_media
    #       match:title = .*imv.*
    #       float = on
    #       opaque = on
    #       size = 70% 70%
    #   }
    #
    #   windowrule {
    #       name = photo_media
    #       match:content = photo
    #       float = on
    #       opaque = on
    #       size = 70% 70%
    #   }
    #
    #   windowrule {
    #       name = pdf_viewer
    #       match:title = .*\.pdf$
    #       float = on
    #       opaque = on
    #       maximize = on
    #   }
    #
    #   windowrule {
    #       name = youtube_opaque
    #       match:title = .*YouTube.*
    #       opaque = on
    #   }
    #
    #   windowrule {
    #       name = swappy_screenshot
    #       match:title = swappy
    #       opaque = on
    #       center = on
    #       stay_focused = on
    #   }
    #
    #   windowrule {
    #       name = brave_opacity
    #       match:class = ^(brave-browser)$
    #       opacity = 1.0 override 1.0 override
    #   }
    #
    #   windowrule {
    #       name = vscode_opacity
    #       match:class = ^(code)$
    #       opacity = 1.0 override 1.0 override
    #   }
    #
    #   windowrule {
    #       name = obsidian_opacity
    #       match:class = ^(obsidian)$
    #       opacity = 1.0 override 1.0 override
    #   }
    #
    #   windowrule {
    #       name = dolphin_opacity
    #       match:class = ^(Dolphin)$
    #       opacity = 1.0 override 1.0 override
    #   }
    #
    #   windowrule {
    #       name = wezterm_dropdown
    #       match:title = ^wezterm_dropdown$
    #       float = on
    #   }
    #
    #   windowrule {
    #       name = volume_control
    #       match:title = ^Volume Control$
    #       float = on
    #       opacity = 1.0 override 1.0 override
    #       size = 70% 70%
    #   }
    #
    #   windowrule {
    #       name = discord_workspace
    #       match:class = ^(discord)$
    #       workspace = special:discord
    #       float = on
    #       maximize = on
    #   }
    #
    #   windowrule {
    #       name = spotify_workspace
    #       match:class = ^(spotify)$
    #       workspace = special:spotify
    #       float = on
    #       maximize = on
    #   }
    #
    #   windowrule {
    #       name = calculator_workspace
    #       match:class = qalculate-gtk
    #       workspace = special:calculator
    #       float = on
    #   }
    #
    #   windowrule {
    #       name = overskride_float
    #       match:title = .*overskride$
    #       float = on
    #   }
    #
    #   windowrule {
    #       name = brave_pwa_float
    #       match:class = ^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$
    #       float = on
    #   }
    #
    #   windowrule {
    #       name = network_connections
    #       match:title = .*Network Connections$
    #       float = on
    #   }
    #
    #   # Jetbrains fix
    #   windowrule {
    #       name = jetbrains_flicker_fix
    #       match:class = ^jetbrains-(?!toolbox)
    #       match:title = ^win\d+$
    #       float = on
    #       no_initial_focus = on
    #   }
    # '';
  };
}
