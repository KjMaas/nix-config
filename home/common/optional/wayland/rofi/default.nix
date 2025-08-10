# Window switcher, run dialog and dmenu replacement for Wayland
{ pkgs, ... }:

let
  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/rofi";

  rofi =
    with pkgs;
    rofi-wayland.override {
      plugins = [
        rofi-calc # Do live calculations in rofi!
        rofi-emoji # An emoji selector plugin for Rofi
      ];
    };

in
{

  home.packages = [ rofi ];

  # generate the script to stow rofi's configuration files
  home.file."stow_dotfiles/stow_rofi.sh" = {
    text = stow_script;
    executable = true;
  };

}
