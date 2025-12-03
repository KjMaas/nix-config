{ pkgs, inputs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # Universal Wayland Session Manager
    xwayland.enable = true;
  };
}
