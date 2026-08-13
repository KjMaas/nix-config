-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
	input = {
		kb_layout = "eu",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,
		mouse_refocus = true,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	mods = "ALT",
	direction = "horizontal",
	action = "workspace",
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "scroll_move",
})

hl.gesture({
	fingers = 2,
	direction = "pinch",
	action = "cursorZoom",
	zoom_level = 1,
	mode = "live",
})
