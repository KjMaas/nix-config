{
  services.xserver = {
    desktopManager = {
      gnome.enable = true;
    };

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "klaasjan";
      gdm = {
        enable = true;
        wayland = false;
      };
    };
  };

  services.gnome = {
    core-utilities.enable = false;
  };

}

