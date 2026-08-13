-- -- -- -- -- -- -- --
-- HYPRLAND CONFIG.  --
-- -- -- -- -- -- -- --

mainMod = "SUPER" -- Sets "Windows" key as main modifier
terminal = "kitty"
fileManager = "thunar"
-- local menu = "hyprlauncher"
menu = "rofi -show"
locker = "hyprlock"

require("conf/monitors")
require("conf/autostart")
require("conf/environment")
require("conf/appearance")
require("conf/animations")
require("conf/layouts")
require("conf/input")
require("conf/keybindings")
require("conf/rules")
