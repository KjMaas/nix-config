{

  services.gammastep = {
    enable = true;

    provider = "geoclue2"; # "manual"

    temperature = {
      day = 6000;
      night = 3600;
    };

    settings = {
      general.adjustment-method = "wayland";
      general.fade = true;

      manual.lat = 45.17869;
      manual.lon = 5.71497;

      wayland.screen = 0;
    };

  };

}
