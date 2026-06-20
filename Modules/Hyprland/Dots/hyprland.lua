

-- Variables for launching stuff
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "hyprlauncher"

-- My main modifier
local mainMod = "SUPER"
local ipc = "noctalia-shell ipc call"




-- -----------------------------------------------------
-- Monitors
-- -----------------------------------------------------
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1",
})
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "preferred",
    position = "auto-right",
    scale    = "1",
})
hl.monitor({
    output   = "DP-3",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})
hl.monitor({
    output   = "HEADLESS-1",
    mode     = "preferred",
    position = "1920x1080@60",
    scale    = "1",
})

-- TODO Setup hyprsplit
-- hl.plugin("/etc/hyprland/plugins/hyprsplit.so")
-- hl.plugin({
--     hyprsplit = {
--         num_workspaces = 10,
--         persistent_workspaces = true
--     }
-- })


-- Automatically startign stuff
hl.on("hyprland.start", function () 
  hl.exec_cmd("noctalia-shell")
  -- hl.exec_cmd(terminal) -- Set aside for a fish autostart function
end)


-- Random env variables
hl.env("HYPRCURSOR_THEME", "breeze_cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")



hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            tap_and_drag = true
        },
        numlock_by_default = true
    },

    decoration = {
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
        },
    },

    misc = {
        disable_hyprland_logo = true,   -- Sorry hyprland devs :(
        disable_splash_rendering = true,
        background_color = "0x24273a"
    },

    -- binds = {
    --     workspace_back_and_forth = true,
    --     allow_pin_fullscreen = true,
    --     drag_threshold = 10
    -- },

})

-- Movements between workspaces (animations and gestures)
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


-- hl.layerrule("blur, logout_dialog")
--
-- hl.windowrulev2("float, title:(.*mpv$)")
-- hl.windowrulev2("opaque, title:(.*mpv$)")
-- hl.windowrulev2("size 50% 50%, title:(.*mpv$)")
--
-- hl.windowrulev2("float, class:(wallrizz)")
-- hl.windowrulev2("opaque, class:(wallrizz)")
-- hl.windowrulev2("size 70% 50%, class:(wallrizz)")
--
-- hl.windowrulev2("float, class:(MeepMeep)")
-- hl.windowrulev2("opaque, class:(MeepMeep)")
-- hl.windowrulev2("size 50% 50%, class:(MeepMeep)")
--
-- hl.windowrulev2("float, title:(.*imv.*)")
-- hl.windowrulev2("opaque, title:(.*imv.*)")
-- hl.windowrulev2("size 70% 70%, title:(.*imv.*)")
--
-- hl.windowrulev2("float, title:(.*\\.pdf$)")
-- hl.windowrulev2("opaque, title:(.*\\.pdf$)")
-- hl.windowrulev2("maximize, title:(.*\\.pdf$)")
--
-- hl.windowrulev2("opaque, title:(.*YouTube.*)")
--
-- hl.windowrulev2("opaque, title:(swappy)")
-- hl.windowrulev2("center, title:(swappy)")
-- hl.windowrulev2("stayfocused, title:(swappy)")
--
-- hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(brave-browser)$")
-- hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(code)$")
-- hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(obsidian)$")
-- hl.windowrulev2("opacity 1.0 override 1.0 override, class:^(Dolphin)$")
--
-- hl.windowrulev2("float, title:^wezterm_dropdown$")
--
-- hl.windowrulev2("float, title:^Volume Control$")
-- hl.windowrulev2("opacity 1.0 override 1.0 override, title:^Volume Control$")
-- hl.windowrulev2("size 70% 70%, title:^Volume Control$")
--
-- hl.windowrulev2("workspace special:discord, class:^(discord)$")
-- hl.windowrulev2("float, class:^(discord)$")
-- hl.windowrulev2("maximize, class:^(discord)$")
--
-- hl.windowrulev2("workspace special:spotify, class:^(spotify)$")
-- hl.windowrulev2("float, class:^(spotify)$")
-- hl.windowrulev2("maximize, class:^(spotify)$")
--
-- hl.windowrulev2("workspace special:calculator, class:(qalculate-gtk)")
-- hl.windowrulev2("float, class:(qalculate-gtk)")
--
-- hl.windowrulev2("float, title:(.*overskride$)")
-- hl.windowrulev2("float, class:^(brave-nngceckbapebfimnlniiiahkandclblb-Default)$")
-- hl.windowrulev2("float, title:(.*Network Connections$)")
--
-- hl.windowrulev2("float, class:^jetbrains-(?!toolbox), title:^win\\d+$")
-- hl.windowrulev2("noinitialfocus, class:^jetbrains-(?!toolbox), title:^win\\d+$")
--

-- Some of the workspaces
-- hl.workspace("special:discord, on-created-empty:uwsm app -- discord")
-- hl.workspace("special:spotify, on-created-empty:uwsm app -- spotify")
-- hl.workspace("special:messages, on-created-empty:uwsm app -- brave --new-window https://messages.google.com/web/u/1/conversations")


-- Keybinds start here

-- Magic workspaces
hl.bind(mainMod.. " + O", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(mainMod.. " + V", hl.dsp.exec_cmd("fish -c clipboard_to_type")) -- TODO bring over fish command

-- Meta actions
hl.bind(mainMod.. " + SHIFT + l", hl.dsp.exec_cmd("fish -c wlogout_uniqe")) -- TODO change to match noctalia
hl.bind(mainMod.. " + L", hl.dsp.exec_cmd("hyprlock")) -- TODO change to match noctalia
hl.bind(mainMod.. " + SHIFT + C", hl.dsp.exec_cmd('pypr menu "Color picker"'))
hl.bind(mainMod.. " + SHIFT + Q", hl.dsp.window.close())
-- hl.bind("${mainMod} + SHIFT + F", hl.dsp.togglefloating(""))
-- hl.bind("${mainMod} + CTRL + F", hl.dsp.fullscreen("0"))
-- hl.bind("${mainMod} + Z", hl.dsp.exec_cmd("pypr zoom"))
--
-- -- Opening Apps (Wrapped in uwsm)
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle"))
hl.bind(mainMod.. " + B", hl.dsp.exec_cmd("uwsm app -- brave")) -- ("uwsm app -- brave"))
hl.bind(mainMod.. " + T", hl.dsp.exec_cmd("uwsm app -- kitty")) 
hl.bind(mainMod.. " + I", hl.dsp.exec_cmd("code"))
hl.bind(mainMod.. " + E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
hl.bind(mainMod.. " + G", hl.dsp.exec_cmd("uwsm app -- steam"))
-- hl.bind("${mainMod} + N", hl.dsp.exec_cmd("uwsm app -- obsidian"))
--
-- -- Utilities
-- hl.bind("${mainMod} + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
-- hl.bind("${mainMod} + SHIFT + T", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tesseract - - | wl-copy'))
-- hl.bind("${mainMod} + SHIFT + E", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
-- hl.bind("${mainMod} + SHIFT + V", hl.dsp.exec_cmd("uwsm app -- emote"))
-- hl.bind("${mainMod} + C", hl.dsp.exec_cmd("hyprpicker -a"))
--
-- -- Special workspaces
-- hl.bind("${mainMod} + D", hl.dsp.togglespecialworkspace("discord"))
-- hl.bind("${mainMod} + M", hl.dsp.togglespecialworkspace("messages"))
-- hl.bind("${mainMod} + S", hl.dsp.togglespecialworkspace("spotify"))
--
-- -- Updated the fallback launch here to use uwsm
-- hl.bind("${mainMod} + K", hl.dsp.exec_cmd("pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || uwsm app -- qalculate-gtk &"))
-- hl.bind("${mainMod} + SHIFT + J", hl.dsp.movetoworkspace("special:magic"))
-- hl.bind("${mainMod} + J", hl.dsp.togglespecialworkspace("magic"))

-- Media Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc.. "volume increase"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc.. "volume decrease"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc.. "volume muteOutput"))
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("volumectl -m toggle-mute")) -- removed because my keyboard doesn't have this key
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc.. "brightness increase"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc.. "brightness decrease"))

-- Workspaces 
for i = 1, 9 do
    hl.bind(mainMod.. " + " .. tostring(i), hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod.. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod.. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod.. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- To move between workspaces
hl.bind(mainMod.. " + code:60", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod.. " + code:59", hl.dsp.focus({ workspace = "e-1" }))

-- Mouse Resizing
-- hl.bind(mainMod.. " + mouse:272", hl.dsp.togglefloating(""), { release = true })
-- hl.bind(mainMod.. " + mouse:273", hl.dsp.pin(""), { release = true })
-- hl.bindm(mainMod.." + mouse:272", hl.dsp.movewindow())
-- hl.bindm(mainMod.. " + mouse:273", hl.dsp.resizewindow())
