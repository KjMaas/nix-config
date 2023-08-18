{ pkgs, ... }:

{
  qt = {
    enable = true;

    ## Manage Theme and Style selection to QT env. variables (see below)
    # platformTheme = "gtk";
    # style = {
    #   name = "gtk2";
    #   package = pkgs.qt6gtk2;
    # };

  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "gtk";
    QT_STYLE_OVERRIDE = "gtk2";

    QT_SCALE_FACTOR = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct          # Qt5 Configuration Tool
    libsForQt5.qt5.qtwayland  # A cross-platform application framework for C++
    libsForQt5.qtstyleplugins # Additional style plugins for Qt5, including BB10, GTK, Cleanlooks, Motif, Plastique
    adwaita-qt                # Qt5 themes
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra

  #   # ToCheck[17/08/2023] : pkg only on the unstable channel for now
  #   qt6Packages.qt6ct
  #   qt6.qtwayland
  #   adwaita-qt6

  ];

}
