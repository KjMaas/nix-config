{ pkgs, inputs,  ... }:

let
  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/hyprland";

in
{
  imports = [
    # The actual Hyprland module
    inputs.hyprland.homeManagerModules.default

    # Default Terminal
    ../../kitty
    # Quick-Menu
    ../rofi
    # Everything-Bar
    ../waybar
    # Notifications
    ../mako
    # Screen Lock
    ../swaylock
    # Idle Daemon
    ../swayidle
  ];

  # load native (not nixified) configuration file
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
    extraConfig = ''

      # source "out of store" configuration for hyprland.
      # edits done to the following file will be taken into account directly after saving
      # (there's no need to rebuild a new nixos/HM generation)
      source=~/.config/hypr/hyprland_not_nixified.conf
    '';
  };

  # generate the script to stow hyprland's configuration files
  home.file."stow_dotfiles/stow_hyprland.sh" = {
    enable = true;
    text = stow_script;
    executable = true;
  };

  home.packages = with pkgs; [ 
    # hardware control
    pamixer       # Pulseaudio command line mixer

    # clipboard
    wl-clipboard  # Command-line copy/paste utilities for Wayland

    # screenshots
    grim          # Grab images from a Wayland compositor
    slurp         # Select a region in a Wayland compositor
    swappy        # A Wayland native snapshot editing tool

    # Color Picker
    hyprpicker    # A wlroots-compatible Wayland color picker that does not suck

    # Wallpaper setter
    swww          # Efficient animated wallpaper daemon for wayland, controlled at runtime

    # Forward graphics through ssh
    waypipe       # A network proxy for Wayland clients (applications)
  ];

  services.clipman = {
    enable = true; # A simple clipboard manager for Wayland
  };

}
