{
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # Use same config for linux console
    useXkbConfig = true;
  };

  services.xserver = {
    # Configure keymap in X11
    layout = "eu";
    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
  };

}

