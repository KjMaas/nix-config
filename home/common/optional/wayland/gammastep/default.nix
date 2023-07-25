{

  services.gammastep = {
    enable = true;

    provider = "geoclue2";

    temperature = {
      day = 6000;
      night = 3600;
    };

    dawnTime = ;
    duskTime = ;

    settings = {
      general.adjustment-method = "wayland";
      general.fade = true;
      general.location-provider = "manual";

      manual.lat = 45.17869;
      manual.lon = 5.71497;

      wayland.screen = 0;
    };

  };

}
