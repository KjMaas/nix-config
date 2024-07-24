# Window switcher, run dialog and dmenu replacement for Wayland
{ pkgs, ... }:

let
  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/rofi";

  # TODO: switch back to mainline nixpkgs once ABI version missmatch is solved for rofi-wayland vs plugins
  # https://github.com/NixOS/nixpkgs/issues/298539
  # oldPkgs = import (builtins.fetchTarball {
  #   url = "https://github.com/NixOS/nixpkgs/releases/tag/23.11";
  # }) { };
  pkgs2311 = import (builtins.fetchTarball { url = "https://github.com/NixOS/nixpkgs/archive/refs/tags/23.11.tar.gz"; }) {};

  rofi = with pkgs2311; rofi-wayland.override { 
    plugins = [ 
      rofi-calc   # Do live calculations in rofi!
      rofi-emoji  # An emoji selector plugin for Rofi
    ]; 
  };

in
{

  home.packages = [ 
    rofi
  ];

  # generate the script to stow rofi's configuration files
  home.file."stow_dotfiles/stow_rofi.sh" = {
    text = stow_script;
    executable = true;
  };

  # ToDo: nixify the rofi configuration once it's stabilised
  # programs.rofi = {
  #   enable = true;
  #   package = pkgs.rofi-wayland;
  #   plugins = with pkgs; [ rofi-calc rofi-emoji ];
  #   location = "bottom";
  #   theme = ./theme/colors.rasi;
  # };

}
