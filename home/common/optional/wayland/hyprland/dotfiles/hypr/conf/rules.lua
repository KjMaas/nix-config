-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
	name = "no-gaps-wtv1",
	match = { float = false, workspace = "w[tv1]" },
	border_size = 0,
	rounding = 0,
})
hl.window_rule({
	name = "no-gaps-f1",
	match = { float = false, workspace = "f[1]" },
	border_size = 0,
	rounding = 0,
})

-- Ignore maximize requests from all apps
local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Floating terminal window
hl.window_rule({
	name = "floating-terminal",
	match = { class = "kitty", title = "floating terminal" },
	float = true,
	size = { 720, 500 },
	center = true,
	opaque = true,
	no_blur = true,
})

-- OKLCH color-picker (Nvim popup)
hl.window_rule({
	name = "oklch-color-picker",
	match = { title = "Oklch Color Picker" },
	float = true,
	size = { 500, 500 },
	center = true,
	opaque = true,
})

-- Picture in Picture
hl.window_rule({
	name = "picture-in-picture",
	match = { title = "Picture in picture" },
	float = true,
	size = { 500, 300 },
	move = { "(monitor_w-510)", "(monitor_h-350)" },
	pin = true,
	opaque = true,
	no_dim = true,
	no_initial_focus = true,
	force_rgbx = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})
