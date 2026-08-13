-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more
local function layout_bind(bind_table)
	return function()
		local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

		if not workspace then
			return
		end

		local layout = workspace.tiled_layout

		if bind_table[layout] then
			hl.dispatch(bind_table[layout])
		end
	end
end

-- Terminal
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal .. " -1 -o allow_remote_control=yes"))
hl.bind(
	mainMod .. " + SHIFT + RETURN",
	hl.dsp.exec_cmd(terminal .. " --title='floating terminal' -o allow_remote_control=yes")
)
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd(terminal .. " btop"))

-- Window management
local closeWindowBind = hl.bind(mainMod .. " + CONTROL + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

hl.bind(
	mainMod .. " + CONTROL + ESCAPE",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + CONTROL + f", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + v", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + p", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + CONTROL + F", hl.dsp.window.pin())
hl.bind(mainMod .. " + B", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.window.move({ workspace = "previous", follow = false }))

-- Lockscreen
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(locker))

-- Waybar toggle
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.exec_cmd("pkill -USR1 waybar"))

-- Battery save script
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.config/hypr/scripts/savebatterylife.sh"))

-- Rofi
hl.bind(mainMod .. " + CONTROL + C", hl.dsp.exec_cmd("rofi -show calc"))
hl.bind(mainMod .. " + CONTROL + E", hl.dsp.exec_cmd("rofi -show emoji -matching normal"))
hl.bind(mainMod .. " + CONTROL + W", hl.dsp.exec_cmd("rofi -show window"))

-- Clipboard (cliphist via rofi)
hl.bind(
	mainMod .. " + SHIFT + P",
	hl.dsp.exec_cmd(
		"rofi -modi clipboard:$HOME/.config/rofi/scripts/cliphist-rofi-img.sh -show clipboard -show-icons"
			.. " -theme-str 'element-icon { size: 50px;}'"
			.. " -theme-str 'window {height: 300px; width:80%; }'"
	)
)

-- Screenshot
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("flameshot gui"))

-- Color picker
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker --autocopy --format=hex"))

-- Notification dismiss
hl.bind("CONTROL + Space", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind("CONTROL + SHIFT + Space", hl.dsp.exec_cmd("makoctl dismiss --all"))

-- Move focus
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Swap windows
hl.bind(
	mainMod .. " + SHIFT + H",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol l"), -- Scrolling: swap column with left one
		dwindle = hl.dsp.window.move({ direction = "left" }),
		monocle = hl.dsp.layout("cycleprev"),
		master = hl.dsp.layout("cycleprev"),
	})
)
hl.bind(
	mainMod .. " + SHIFT + L",
	layout_bind({
		scrolling = hl.dsp.layout("swapcol r"),
		dwindle = hl.dsp.window.move({ direction = "right" }),
		monocle = hl.dsp.layout("cyclenext"),
		master = hl.dsp.layout("cyclenext"),
	})
)
hl.bind(
	mainMod .. " + SHIFT + J",
	layout_bind({
		scrolling = hl.dsp.window.move({ direction = "down" }),
		dwindle = hl.dsp.window.move({ direction = "down" }),
		monocle = hl.dsp.layout("cyclenext"),
		master = hl.dsp.layout("cyclenext"),
	})
)
hl.bind(
	mainMod .. " + SHIFT + K",
	layout_bind({
		scrolling = hl.dsp.window.move({ direction = "up" }),
		dwindle = hl.dsp.window.move({ direction = "up" }),
		monocle = hl.dsp.layout("cycleprev"),
		master = hl.dsp.layout("cycleprev"),
	})
)

-- Switch workspaces with mainMod + [0-9] (switches to previous workspace if already active)
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0

	hl.bind(mainMod .. " + " .. key, function()
		local workspace = hl.get_active_workspace()

		if workspace and workspace.id == i then
			hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = i }))
		end
	end)

	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SPACE", hl.dsp.workspace.toggle_special("👻"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.move({ workspace = "special:👻" }))
hl.bind(mainMod .. " + CONTROL + SPACE", hl.dsp.window.move({ workspace = "e+0" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh 2 -e4 -n2"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("~/.config/hypr/scripts/brightness.sh -2 -e4 -n2"),
	{ locked = true, repeating = true }
)

-- Brave profiles: [i]ncognito  persona[l]  [p]ro  [w]attabase
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.submap("braveprofiles"))
hl.define_submap("braveprofiles", "reset", function()
	hl.bind("i", hl.dsp.exec_cmd("brave --incognito"))
	hl.bind("l", hl.dsp.exec_cmd("brave --profile-directory=Default"))
	hl.bind("p", hl.dsp.exec_cmd("brave --profile-directory='Profile 1'"))
	hl.bind("w", hl.dsp.exec_cmd("brave --profile-directory='Profile 4'"))
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("l", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })
	hl.bind("h", hl.dsp.window.resize({ x = -100, y = 0 }), { repeating = true })
	hl.bind("k", hl.dsp.window.resize({ x = 0, y = -100 }), { repeating = true })
	hl.bind("j", hl.dsp.window.resize({ x = 0, y = 100 }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)

-- Dwindle layout binds
hl.bind(mainMod .. " + E", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.layout("swapsplit"))
hl.bind(mainMod .. " + CONTROL + P", hl.dsp.exec_cmd("hyprctl dispatch workspaceopt allpseudo"))
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.layout("preselect u"))
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.layout("preselect r"))
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.layout("preselect d"))
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.layout("preselect l"))

-- Master layout binds
hl.bind(mainMod .. " + N", hl.dsp.layout("orientationnext"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.layout("orientationprev"))
hl.bind(mainMod .. " + A", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.layout("removemaster"))

-- Tabbed windows (groups)
hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.group.lock_active({ action = "toggle" }))
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.group.prev())
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.group.next())
hl.bind(mainMod .. " + CONTROL + SHIFT + H", hl.dsp.group.move_window({ forward = false }))
hl.bind(mainMod .. " + CONTROL + SHIFT + L", hl.dsp.group.move_window({ forward = true }))
hl.bind(mainMod .. " + CONTROL + SHIFT + L", hl.dsp.window.move({ into_group = "right" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + H", hl.dsp.window.move({ into_group = "left" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + J", hl.dsp.window.move({ into_group = "up" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + K", hl.dsp.window.move({ into_group = "down" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + J", hl.dsp.window.move({ out_of_group = "up" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + K", hl.dsp.window.move({ out_of_group = "down" }))
