-- ~/.config/hypr/hyprland.lua

local mainMod = "SUPER"

-- -----------------------------------------------------
-- Monitors
-- -----------------------------------------------------
hl.monitor("eDP-1, preferred, auto, 1")
hl.monitor("DP-1, preferred, 0x0 , 1")
hl.monitor("HDMI-A-1, preferred, auto-right, 1")
hl.monitor("DP-3, preferred, auto-left, 1")
hl.monitor(", preferred, auto, 1, mirror, eDP-1")
hl.monitor("HEADLESS-1, 1920x1080@60, 0x0, 1")

-- -----------------------------------------------------
-- Plugins
-- -----------------------------------------------------
hl.plugin("/etc/hyprland/plugins/hyprsplit.so")
hl.plugin({
    hyprsplit = {
        num_workspaces = 10,
        persistent_workspaces = true
    }
})

-- -----------------------------------------------------
-- Autostart & Environment
-- -----------------------------------------------------
hl.exec_once("fish -c autostart")
hl.exec_once("kded6")
hl.exec_once("kiod6")
hl.env("QT_QPA_PLATFORMTHEME,kde")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION,1")
hl.exec_once("gsettings set org.freedesktop.appearance color-scheme 1")
hl.exec_once("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

hl.source("~/.config/hypr/gruvbox.conf")

hl.env("HYPRCURSOR_THEME,breeze_cursors")
hl.env("HYPRCURSOR_SIZE,24")
hl.env("XCURSOR_THEME,breeze_cursors")
hl.env("XCURSOR_SIZE,24")
hl.env("XDG_MENU_PREFIX,plasma-")
hl.env("XDG_SESSION_TYPE,wayland")
hl.env("XDG_CURRENT_DESKTOP,Hyprland")
hl.env("XDG_SESSION_DESKTOP,Hyprland")

-- -----------------------------------------------------
-- General Settings
-- -----------------------------------------------------
hl.input({
    kb_layout = "us",
    follow_mouse = 1,
    touchpad = {
        natural_scroll = true,
        ['tap-and-drag'] = true
    },
    sensitivity = 0
})

hl.general({
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    ['col.active_border'] = "$yellow",
    ['col.inactive_border'] = "$surface1",
    layout = "dwindle"
})

hl.decoration({
    rounding = 10,
    blur = {
        size = 8,
        passes = 2
    },
    shadow = {
        enabled = true,
        range = 15,
        render_power = 3,
        offset = "0, 0",
        color = "$yellow",
        color_inactive = "0xff$baseAlpha"
    },
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0
})

hl.animations({
    enabled = true,
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05",
    animation = {
        "windows, 1, 2, myBezier",
        "windowsOut, 1, 2, default, popin 80%",
        "border, 1, 3, default",
        "fade, 1, 2, default",
        "workspaces, 1, 1, default"
    }
})

hl.dwindle({
    pseudotile = true,
    preserve_split = true,
    force_split = 2
})

hl.master({
    new_status = "master"
})

hl.gesture("3, horizontal, workspace")

hl.misc({
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    background_color = "0x24273a"
})

hl.binds({
    workspace_back_and_forth = true
})

hl.device({
    name = "epic mouse V1",
    sensitivity = -0.5
})

-- -----------------------------------------------------
-- Window & Layer Rules
-- -----------------------------------------------------
hl.layerrule("blur, logout_dialog")

hl.windowrulev2("float, title:(.*mpv$)")
hl.windowrulev2("opaque, title:(.*mpv$)")
hl.windowrulev2("size 50% 50%, title:(.*mpv$)")

hl.windowrulev2("float, class:(wallrizz)")
hl.windowrulev2("opaque, class:(wallrizz)")
hl.windowrulev2("size 70% 50%, class:(wallrizz)")

hl.windowrulev2("float, class:(MeepMeep)")
hl.windowrulev2("opaque, class:(MeepMeep)")
hl.windowrulev2("size 50% 50%, class:(MeepMeep)")

hl.windowrulev2("float, title:(.*imv.*)")
hl.windowrulev2("opaque, title:(.*imv.*)")
hl.windowrulev2("size 70% 70%, title:(.*imv.*)")

hl.windowrulev2("float, title:(.*\\.pdf$)")
hl.windowrulev2("opaque, title:(.*\\.pdf$)")
hl.windowrulev2("maximize, title:(.*\\.pdf$)")

hl.windowrulev2("opaque, title:(.*YouTube.*)")

hl.windowrulev2("opaque, title:(swappy)")
hl.windowrulev2("center, title:(swappy)")
hl.windowrulev2("stayfocused, title:(swappy)")

hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(brave-browser)$")
hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(code)$")
hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(obsidian)$")
hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(Dolphin)$")

hl.windowrulev2("float, title:^wezterm_dropdown$")

hl.windowrulev2("float, title:^Volume Control$")
hl.windowrulev2("opacity 1.0 override 1.0 override, title:^Volume Control$")
hl.windowrulev2("size 70% 70%, title:^Volume Control$")

hl.windowrulev2("workspace special:discord, class:^(discord)$")
hl.windowrulev2("float, class:^(discord)$")
hl.windowrulev2("maximize, class:^(discord)$")

hl.windowrulev2("workspace special:spotify, class:^(spotify)$")
hl.windowrulev2("float, class:^(spotify)$")
hl.windowrulev2("maximize, class:^(spotify)$")

hl.windowrulev2("workspace special:calculator, class:(qalculate-gtk)")
hl.windowrulev2("float, class:(qalculate-gtk)")

hl.windowrulev2("float, title:(.*overskride$)")
hl.windowrulev2("float, class:^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$")
hl.windowrulev2("float, title:(.*Network Connections$)")

hl.windowrulev2("float, class:^jetbrains-(?!toolbox), title:^win\\d+$")
hl.windowrulev2("noinitialfocus, class:^jetbrains-(?!toolbox), title:^win\\d+$")

-- -----------------------------------------------------
-- Special Workspaces
-- -----------------------------------------------------
hl.workspace("special:discord, on-created-empty:discord")
hl.workspace("special:spotify, on-created-empty:uwsm app -- spotify")
hl.workspace("special:messages, on-created-empty:brave --new-window https://messages.google.com/web/u/1/conversations")

-- -----------------------------------------------------
-- Keybindings
-- -----------------------------------------------------
hl.source("~/.config/hypr/hyprvim/init.conf")

-- Scratchpads
hl.bind(mainMod, "O", "exec", "pypr toggle term")
hl.bind(mainMod, "V", "exec", "fish -c clipboard_to_type")
hl.bind(mainMod .. " CTRL", "V", "exec", "pypr toggle volume")
hl.bind(mainMod .. " CTRL", "E", "exec", "pypr expose")
hl.bind(mainMod, "Z", "exec", "pypr zoom")

-- Meta actions
hl.bind(mainMod .. " SHIFT", "l", "exec", "fish -c wlogout_uniqe") -- TODO change to match noctalia
hl.bind(mainMod, "L", "exec", "hyprlock") -- TODO change to match noctalia
hl.bind(mainMod .. " SHIFT", "C", "exec", 'pypr menu "Color picker"')
hl.bind(mainMod .. " SHIFT", "Q", "killactive")
hl.bind(mainMod .. " SHIFT", "F", "togglefloating", "")
hl.bind(mainMod .. " CTRL", "F", "fullscreen", "0")

-- Opening Apps
hl.bind(mainMod, "T", "exec", "kitty")
hl.bind("ALT", "SPACE", "exec", "rofi -show drun")
hl.bind(mainMod, "B", "exec", "brave")
hl.bind(mainMod, "T", "exec", "kitty")
hl.bind("SUPER", "I", "exec", "code")
hl.bind(mainMod, "E", "exec", "dolphin")
hl.bind(mainMod, "G", "exec", "steam")
hl.bind(mainMod, "N", "exec", "obsidian")

-- Utilities
hl.bind(mainMod .. " SHIFT", "S", "exec", 'grim -g "$(slurp)" - | wl-copy')
hl.bind(mainMod .. " SHIFT", "T", "exec", 'grim -g "$(slurp)" - | tesseract - - | wl-copy')
hl.bind(mainMod .. " SHIFT", "E", "exec", 'grim -g "$(slurp)" - | swappy -f -')
hl.bind(mainMod .. " SHIFT", "V", "exec", "emote")
hl.bind(mainMod, "C", "exec", "hyprpicker -a")

-- Special workspaces
hl.bind(mainMod, "D", "togglespecialworkspace", "discord")
hl.bind(mainMod, "M", "togglespecialworkspace", "messages")
hl.bind(mainMod, "S", "togglespecialworkspace", "spotify")
hl.bind("SUPER", "K", "exec", "pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || qalculate-gtk &")
hl.bind(mainMod .. " SHIFT", "J", "movetoworkspace", "special:magic")
hl.bind(mainMod, "J", "togglespecialworkspace", "magic")

-- Media Controls
hl.bind("", "XF86AudioRaiseVolume", "exec", "volumectl -u up")
hl.bind("", "XF86AudioLowerVolume", "exec", "volumectl -u down")
hl.bind("", "XF86AudioMute", "exec", "volumectl toggle-mute")
hl.bind("", "XF86AudioMicMute", "exec", "volumectl -m toggle-mute")
hl.bind("", "XF86MonBrightnessUp", "exec", "lightctl -D intel_backlight up")
hl.bind("", "XF86MonBrightnessDown", "exec", "lightctl -D intel_backlight down")


-- Workspaces 
for i = 1, 9 do
    hl.bind(mainMod, tostring(i), "split:workspace", tostring(i))
    hl.bind(mainMod .. " SHIFT", tostring(i), "split:movetoworkspace", tostring(i))
end
hl.bind(mainMod, "0", "split:workspace", "10")
hl.bind(mainMod .. " SHIFT", "0", "split:movetoworkspace", "10")

-- To move between workspaces
hl.bind(mainMod, "code:60", "workspace", "e+1")
hl.bind(mainMod, "code:59", "workspace", "e-1")
hl.bind(mainMod, "code:61", "workspace", "empty")

-- Mouse Resizing
hl.bindm(mainMod, "mouse:272", "movewindow")
hl.bindm(mainMod, "mouse:273", "resizewindow")
-- hl.bindm(mainMod ALT, "mouse:273", "resizewindow")
hl.bindm(mainMod, "mouse:273", "resizewindow")
