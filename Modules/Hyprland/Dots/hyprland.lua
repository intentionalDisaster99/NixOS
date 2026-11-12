-- Variables for launching stuff
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"

-- My main modifier
local mainMod = "SUPER"
local ipc = "noctalia-shell ipc call "

-- -----------------------------------------------------
-- Monitors
-- -----------------------------------------------------
hl.monitor({
	output = "eDP-1",
	mode = "preferred",
	position = "auto",
	scale = "1",
})
hl.monitor({
	output = "DP-1",
	mode = "preferred",
	position = "auto-right",
	scale = "1",
})
hl.monitor({
	output = "DP-2",
	mode = "preferred",
	position = "auto-right",
	scale = "1",
})
hl.monitor({
	output = "HDMI-A-1",
	mode = "preferred",
	-- position = "auto-up",
	position = "auto-left",
	scale = "1",
})
hl.monitor({
	output = "DP-3",
	mode = "preferred",
	position = "0x0",
	scale = "1",
})
hl.monitor({
	output = "HEADLESS-1",
	mode = "preferred",
	position = "1920x1080@60",
	scale = "1",
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
hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia-shell")
	--   hl.exec_cmd(ipc.. " lockScreen locIk")
	--   hl.exec_cmd("pypr") -- TODO move to fish autostart
	hl.exec_cmd('fish -c "autostart"')
end)

-- Random env variables
hl.env("HYPRCURSOR_THEME", "breeze_cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "breeze_cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
			tap_and_drag = true,
		},
		numlock_by_default = true,
		-- kb_options = "caps:swapescape"
	},

	-- decoration = {
	--     rounding = 10,
	--     blur = {
	--         size = 8,
	--         passes = 2
	--     },
	-- shadow = {
	--     enabled = true,
	--     range = 15,
	--     render_power = 30,
	--     offset = "0, 0",
	-- },
	-- glow = {
	--     enabled = true,
	--     range = 20,
	-- }
	-- },

	misc = {
		disable_hyprland_logo = true, -- Sorry hyprland devs :(
		disable_splash_rendering = true,
		background_color = "0x24273a",
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
	action = "workspace",
})

hl.curve("fast", { type = "bezier", points = { { 1, 0 }, { 0, 1 } } })
hl.animation({ leaf = "global", enabled = true, speed = 4, bezier = "fast" })

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

-- Fixing the screenshot stuff
hl.window_rule({ match = { class = "grim" }, no_anim = 1 })
hl.window_rule({ match = { class = "selector" }, no_anim = 1 })

-- Emacs everywhere needs to float
windowrule = {
  "float, title:^(emacs-everywhere)$",
  "size 800 500, title:^(emacs-everywhere)$",
  "center, title:^(emacs-everywhere)$",
}
-- Some of the workspaces
-- hl.workspace("special:discord, on-created-empty:uwsm app -- discord")
-- hl.workspace("special:spotify, on-created-empty:uwsm app -- spotify")
-- hl.workspace("special:messages, on-created-empty:uwsm app -- brave --new-window https://messages.google.com/web/u/1/conversations")

-- Keybinds start here

-- TEST
-- hl.bind(mainMod.. " + P", hl.dsp.exec_cmd("fish -c \"autostart\""))

-- -- Magic workspaces
-- hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("pypr toggle term"))
-- -- hl.bind(mainMod.. " + V", hl.dsp.exec_cmd("fish -c clipboard_to_type")) -- TODO bring over fish command

-- -- Meta actions
-- hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd('pypr menu "Color picker"'))
-- hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
-- hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({ action = "toggle" }))
-- hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
-- --
-- -- -- Opening Apps (Wrapped in uwsm)
-- hl.bind("ALT + SPACE", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
-- hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- brave"))
-- hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("uwsm app -- kitty"))
-- hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm app -- emacsclient -c -a ''"))
-- -- hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm app -- emacsclient -c -a 'emacs'"))
-- hl.bind(mainMod .. "+ SHIFT + I", hl.dsp.exec_cmd("exec emacsclient --eval '(emacs-everywhere)'"))
-- hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
-- hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("uwsm app -- steam"))
-- hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- obsidian"))

-- -- -- Utilities
-- hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -w 0 -b \\#00000099)" - | wl-copy')) -- Takes a screenshot
-- hl.bind(mainMod .. " + ALT + W", hl.dsp.exec_cmd(ipc .. "wallpaper toggle")) -- Toggles the noctalia wallpaper switcher
-- hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(ipc .. "controlCenter toggle")) -- Opens the noctalia control center
-- hl.bind(mainMod .. " + ALT + I", hl.dsp.exec_cmd(ipc .. "settings toggle")) -- Opens the noctalia settings panel
-- hl.bind(mainMod .. " + ALT + H", hl.dsp.exec_cmd(ipc .. "bar toggle")) -- Hides or unhides the bar at the top
-- hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"))
-- hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. " launcher clipboard"))
-- hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd(ipc .. " plugin openPanel screen-toolkit"))
-- hl.bind(mainMod .. " + ALT + Q", hl.dsp.exec_cmd(ipc .. " calendar toggle"))
-- hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("fish -c nord-toggle"))

-- hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ipc .. " plugin:screen-toolkit colorPicker"))
-- hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd('grim -g "$(slurp -w 0 -b \\#00000099)" - | swappy -f -'))
-- hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(ipc .. "launcher emoji"))
-- -- hl.bind("${mainMod} + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- -- Noctalia things
-- hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))

-- --
-- -- -- Special workspaces
-- hl.workspace_rule({ workspace = "special:discord", on_created_empty = "uwsm app -- discord" })
-- hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("discord"))
-- hl.workspace_rule({ workspace = "special:spotify", on_created_empty = "uwsm app -- spotify" })
-- hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
-- hl.workspace_rule({
-- 	workspace = "special:messages",
-- 	on_created_empty = "uwsm app -- brave --new-window https://messages.google.com/web/u/1/conversations",
-- })
-- hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("messages"))
-- hl.workspace_rule({
-- 	workspace = "special:groupme",
-- 	on_created_empty = "uwsm app -- brave --new-window https://web.groupme.com",
-- })
-- hl.bind(mainMod .. " + P", hl.dsp.workspace.toggle_special("messages"))
-- hl.workspace_rule({ workspace = "special:magic" })
-- hl.bind(mainMod .. " + J", hl.dsp.workspace.toggle_special("magic"))
-- hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "special:magic" }))
-- hl.workspace_rule({ workspace = "special:calc", on_created_empty = "uwsm app -- qalculate-gtk" })
-- hl.bind(mainMod .. " + K", hl.dsp.workspace.toggle_special("calc"))

--
-- -- Updated the fallback launch here to use uwsm
-- hl.bind("${mainMod} + K", hl.dsp.exec_cmd("pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || uwsm app -- qalculate-gtk &"))
-- Special Workspace Rules
hl.workspace_rule({ workspace = "special:discord", on_created_empty = "uwsm app -- discord" })
hl.workspace_rule({ workspace = "special:spotify", on_created_empty = "uwsm app -- spotify" })
hl.workspace_rule({
	workspace = "special:messages",
	on_created_empty = "uwsm app -- brave --new-window https://messages.google.com/web/u/1/conversations",
})
hl.workspace_rule({
	workspace = "special:groupme",
	on_created_empty = "uwsm app -- brave --new-window https://web.groupme.com",
})
hl.workspace_rule({
	workspace = "special:ptable",
	on_created_empty = "uwsm app -- nucleus",
})
hl.workspace_rule({ workspace = "special:magic" })
hl.workspace_rule({ workspace = "special:calc", on_created_empty = "uwsm app -- qalculate-gtk" })

--------------------------------------------------------------------------------
-- Normal Mode (Direct Hotkeys & Mode Triggers)
--------------------------------------------------------------------------------
-- Mode Triggers
hl.bind(mainMod .. " + O", hl.dsp.submap("open"))
hl.bind(mainMod .. " + P", hl.dsp.submap("power"))
hl.bind(mainMod .. " + U", hl.dsp.submap("noctalia"))
hl.bind(mainMod .. " + T", hl.dsp.submap("toggle"))

-- Normal Hotkeys
hl.bind("ALT + SPACE", hl.dsp.exec_cmd(ipc .. "launcher toggle"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(ipc .. " plugin:screen-toolkit colorPicker"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(ipc .. " launcher clipboard"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pypr zoom"))
hl.bind(mainMod .. " + H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("exec emacsclient --eval '(emacs-everywhere)'"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -w 0 -b \\#00000099)" - | wl-copy'))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd('grim -g "$(slurp -w 0 -b \\#00000099)" - | swappy -f -'))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(ipc .. "launcher emoji"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())

--------------------------------------------------------------------------------
-- Open Mode Submap
--------------------------------------------------------------------------------
hl.define_submap("open", "reset", function()
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("J", hl.dsp.workspace.toggle_special("magic"))
	hl.bind("M", hl.dsp.workspace.toggle_special("messages"))
	hl.bind("N", hl.dsp.exec_cmd("uwsm app -- obsidian"))
	hl.bind("B", hl.dsp.exec_cmd("uwsm app -- brave"))
	hl.bind("I", hl.dsp.exec_cmd("uwsm app -- emacsclient -c -a ''"))
	hl.bind("K", hl.dsp.workspace.toggle_special("calc"))
	hl.bind("E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
	hl.bind("G", hl.dsp.exec_cmd("uwsm app -- steam"))
	hl.bind("O", hl.dsp.exec_cmd("pypr toggle term"))
	hl.bind("T", hl.dsp.exec_cmd("uwsm app -- kitty"))
	hl.bind("H", hl.dsp.workspace.toggle_special("groupme"))
	hl.bind("D", hl.dsp.workspace.toggle_special("discord"))
	hl.bind("S", hl.dsp.workspace.toggle_special("spotify"))
	hl.bind("P", hl.dsp.workspace.toggle_special("ptable"))

-- Also including the extra super press in case you don't lift fast enoguh
	hl.bind(mainMod .. " + J", hl.dsp.workspace.toggle_special("magic"))
	hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("messages"))
	hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("uwsm app -- obsidian"))
	hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- brave"))
	hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("uwsm app -- emacsclient -c -a ''"))
	hl.bind(mainMod .. " + K", hl.dsp.workspace.toggle_special("calc"))
	hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- dolphin"))
	hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("uwsm app -- steam"))
	hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("pypr toggle term"))
	hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("uwsm app -- kitty"))
	hl.bind(mainMod .. " + H", hl.dsp.workspace.toggle_special("groupme"))
	hl.bind(mainMod .. " + D", hl.dsp.workspace.toggle_special("discord"))
	hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("spotify"))
	hl.bind(mainMod .. " + P", hl.dsp.workspace.toggle_special("ptable"))
end)

--------------------------------------------------------------------------------
-- Power Mode Submap
--------------------------------------------------------------------------------
hl.define_submap("power", "reset", function()
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("L", hl.dsp.exec_cmd(ipc .. " lockScreen lock"))
	hl.bind("S", hl.dsp.exec_cmd("systemctl suspend"))
	hl.bind("H", hl.dsp.exec_cmd("systemctl hibernate"))
	hl.bind("D", hl.dsp.exec_cmd("systejctl poweroff"))
	hl.bind("R", hl.dsp.exec_cmd("reboot"))
	hl.bind("M", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"))
end)

--------------------------------------------------------------------------------
-- Noctalia Mode Submap
--------------------------------------------------------------------------------
hl.define_submap("noctalia", "reset", function()
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("W", hl.dsp.exec_cmd(ipc .. "wallpaper toggle"))
	hl.bind("S", hl.dsp.exec_cmd(ipc .. " plugin openPanel screen-toolkit"))
	hl.bind("I", hl.dsp.exec_cmd(ipc .. "settings toggle"))
	hl.bind("C", hl.dsp.exec_cmd(ipc .. "controlCenter toggle"))
	hl.bind("Q", hl.dsp.exec_cmd(ipc .. " calendar toggle"))
end)

--------------------------------------------------------------------------------
-- Toggle Mode Submap
--------------------------------------------------------------------------------
hl.define_submap("toggle", "reset", function()
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("N", hl.dsp.exec_cmd("fish -c nord-toggle"))
end)
-- Media Controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume increase"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume decrease"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume muteOutput"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness increase"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness decrease"))

-- Workspaces
local monitorOffsets = {
	{ "eDP-1", 0 },
	{ "DP-1", 10 },
	{ "DP-2", 20 },
	{ "HDMI-A-1", 30 },
	{ "DP-3", 40 },
	{ "HEADLESS-1", 50 },
}

for _, mon in ipairs(monitorOffsets) do
	local name = mon[1]
	local offset = mon[2]
	for i = 1, 10 do
		hl.workspace_rule({ workspace = tostring(offset + i), monitor = name, persistent = true })
	end
end

for i = 1, 9 do
	hl.bind(mainMod .. " + " .. tostring(i), hl.dsp.focus({ workspace = "m~" .. tostring(i) }))
	hl.bind(mainMod .. " + SHIFT + " .. tostring(i), hl.dsp.window.move({ workspace = "m~" .. tostring(i) }))
end

hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "m~10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "m~10" }))

hl.bind(mainMod .. " + code:60", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + code:59", hl.dsp.focus({ workspace = "m-1" }))

-- Mouse Resizing TODO finish implementing these
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + mouse:273", hl.dsp.window.pin())
hl.bind(mainMod .. " + SHIFT + ALT + mouse:272", hl.dsp.window.pin())
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.bind(mainMod .. " + ALT + mouse:272", hl.dsp.window.resize())

-- For making the screen dim before locking
-- bind = , code:232, exec, brightnessctl set 5%-
-- bind = , code:233, exec, brightnessctl set +5%
hl.bind("code:232", hl.dsp.exec_cmd("brightnessctl set 5%-"))
hl.bind("code:233", hl.dsp.exec_cmd("brightnessctl set +5%"))

-- Colors from noctalia
local decor = require("noctalia-colors")
hl.config(decor)
