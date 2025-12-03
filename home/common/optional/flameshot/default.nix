{
  pkgs,
  config,
  ...
}:
{
  services.flameshot = {
    enable = true;

    # Enable wayland support with this build flag
    package = pkgs.flameshot.override {
      enableWlrSupport = true;
    };

    settings = {
      General = {
        disabledTrayIcon = true;
        showHelp = false;
        showStartupLaunchMessage = false;

        # Auto save to this path
        savePath = "${config.home.homeDirectory}/Pictures/captures";
        filenamePattern = "%F_%H-%M";
        savePathFixed = true;
        saveAsFileExtension = ".jpg";
        saveAfterCopy = true;
        saveLastRegion = true;
        copyPathAfterSave = true;

        drawColor = "#ff8855";
        drawFontSize = 5;
        drawThickness = 3;

        showMagnifier = true;
        squareMagnifier = true;
        showSidePanelButton = true;

        # For wayland
        useGrimAdapter = true;
      };
    };
  };

  # Hide the flameshot wayland warning (https://github.com/flameshot-org/flameshot/issues/3186)
  services.dunst.settings.ignore_flameshot_warning = {
    body = "grim's screenshot component is implemented based on wlroots, it may not be used in GNOME or similar desktop environments";
    format = "";
  };
}
