{ pkgs, inputs, ... }:

let
  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/hyprland";

in
{
  imports = [
    # The actual Hyprland module

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
    systemd.variables = [ "--all" ];
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

  # INFO: solves the "681629 segmentation fault (core dumped)" error for hyprpicker:
  # https://github.com/hyprwm/hyprpicker/issues/51
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.gnome.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  home.packages = with pkgs; [
    # hardware control
    pamixer # Pulseaudio command line mixer

    # clipboard
    wl-clipboard # Command-line copy/paste utilities for Wayland

    # screenshots
    grim # Grab images from a Wayland compositor
    slurp # Select a region in a Wayland compositor
    swappy # A Wayland native snapshot editing tool

    # Color Picker
    hyprpicker # A wlroots-compatible Wayland color picker that does not suck

    # Screen locker
    hyprlock # Hyprland's GPU-accelerated screen locking utility

    # Wallpaper setter
    # swww          # Efficient animated wallpaper daemon for wayland, controlled at runtime
    hyprpaper # A blazing fast wayland wallpaper utility

    # Forward graphics through ssh
    waypipe # A network proxy for Wayland clients (applications)

    # Cursor-theme
    inputs.rose-pine-hyprcursor.packages.x86_64-linux.default
  ];

  services.clipman = {
    enable = true; # A simple clipboard manager for Wayland
  };

  services.cliphist = {
    enable = true;
    allowImages = true;
  };
}
