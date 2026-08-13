-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
	-- Status bar
	hl.exec_cmd("waybar")

	-- Screen sharing
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("systemctl --user import-environment QT_QPA_PLATFORMTHEME")

	-- Battery warning
	hl.exec_cmd("~/.config/hypr/scripts/batterywarning.sh")

	-- Bluetooth
	hl.exec_cmd("blueman-applet")

	-- Wallpaper
	hl.exec_cmd("hyprpaper")

	-- Notification daemon
	hl.exec_cmd("mako")

	-- Clipboard manager
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
