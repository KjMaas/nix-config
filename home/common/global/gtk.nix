# configure GIMP ToolKit - graphical user interface configuration
# https://www.gtk.org/
# https://en.wikipedia.org/wiki/GTK

{ pkgs, ... }:

{

  gtk = {
    enable = true;

    font = {
      name = "Fira Sans";
      size = 11;
    };

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-overlay-scrolling = false
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-overlay-scrolling = false
      '';
    };

  };

  home.packages = with pkgs; [
    gtk3  # A multi-platform toolkit for creating graphical user interfaces
    gtk4  # ... also a multi-platform toolkit for creating graphical user interfaces
  ];

}

