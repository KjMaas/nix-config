-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

-- colorscheme variables
local base00 = "2E3440ff" -- #2E3440
local base01 = "3B4252ff" -- #3B4252
local base02 = "434C5Eff" -- #434C5E
local base03 = "4C566Aff" -- #4C566A
local base04 = "D8DEE9ff" -- #D8DEE9
local base05 = "E5E9F0ff" -- #E5E9F0
local base06 = "ECEFF4ff" -- #ECEFF4
local base07 = "8FBCBBff" -- #8FBCBB
local base08 = "BF616Aff" -- #BF616A
local base09 = "D08770ff" -- #D08770
local base0A = "EBCB8Bff" -- #EBCB8B
local base0B = "A3BE8Cff" -- #A3BE8C
local base0C = "88C0D0ff" -- #88C0D0
local base0D = "81A1C1ff" -- #81A1C1
local base0E = "B48EADff" -- #B48EAD
local base0F = "5E81ACff" -- #5E81AC

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 2,

		col = {
			active_border = { colors = { "rgba(" .. base03 .. ")", "rgba(" .. base0A .. ")" }, angle = 90 },
			inactive_border = { colors = { "rgba(" .. base00 .. ")", "rgba(" .. base0C .. ")" }, angle = 90 },
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,

		dim_inactive = true,
		dim_strength = 0.2,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},

		glow = {
			enabled = true,
			range = 5,
			render_power = 4,
		},
	},

	animations = {
		enabled = true,
	},
})

hl.config({
	debug = {
		overlay = false,
	},
})

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})
