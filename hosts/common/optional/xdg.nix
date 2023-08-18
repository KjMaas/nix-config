{ pkgs, ... }:

{
    

  # Gnome backend lib (daemon) that stores application settings
  # https://wiki.gnome.org/action/show/Projects/dconf?action=show&redirect=dconf
  # fixes the following error on `home-manager switch`:
  # "error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files"
  # D-Bus is a message bus system, a simple way for applications to talk to one another.
  # https://www.freedesktop.org/wiki/Software/dbus/
  programs.dconf.enable = true;

  xdg.portal = {
    # Enables the X Desktop Group (misnomer since it now also supports Wayland)
    # in the process of being renamed to freedesktop.org (fd.o)
    enable = true; 

    # This will make `xdg-open` use the portal to open programs
    # sets the right Environment Vars
    xdgOpenUsePortal = true; # Sets NIXOS_XDG_OPEN_USE_PORTAL=1

    # use either wlr portal OR hyprland portal
    # hyprland's portal (wlr fork) has more features and should be compatible with wlr
    wlr.enable = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      # xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];

  };

  environment.systemPackages = with pkgs; [

    # set of tools (listed below) that allows applications
    # to easily integrate with the desktop environment:
    # xdg-mime
    # xdg-email
    # xdg-desktop-icon
    # xdg-settings
    # xdg-icon-resource
    # xdg-desktop-menu
    # xdg-screensaver
    # xdg-open
    xdg-utils 

  ];

}

