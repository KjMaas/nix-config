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
    # App-launcher
    # ../walker # Too memory intensive for the time being
    ../rofi
    # Everything-Bar
    ../waybar
    # Notifications
    ../mako
    # Screen Lock
    ../swaylock
    # Idle Daemon
    ../swayidle
    # Image viewer
    ../swayimg
  ];

  xdg.portal = {
    # Enables the X Desktop Group (misnomer since it now also supports Wayland)
    # in the process of being renamed to freedesktop.org (fd.o)
    enable = true;

    # This will make `xdg-open` use the portal to open programs
    # sets the right Environment Vars
    xdgOpenUsePortal = true; # Sets NIXOS_XDG_OPEN_USE_PORTAL=1

    extraPortals = with pkgs; [
      # xdg-desktop-portal # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-gtk # Desktop integration portals for sandboxed apps
      xdg-desktop-portal-hyprland # xdg-desktop-portal backend for Hyprland
    ];

    config = {
      common.default = [ "gtk" ];
    };

  };

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
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 16;
  };

  home.packages = with pkgs; [
    # hardware control
    pamixer # Pulseaudio command line mixer

    # clipboard
    wl-clipboard-rs # Command-line copy/paste utilities for Wayland, written in Rust

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
