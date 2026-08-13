-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = "DP-2",
	mode = "2560x1600@60",
	position = "auto-left",
	scale = "1",
	disabled = true,
})
