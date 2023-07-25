{
  networking = {

      hostName = "razer";

      networkmanager.enable = false; # Easiest to use and most distros use this by default.

      wireless = {
        enable = true; # Enables wireless support via wpa_supplicant.

        # Declarative networks
        environmentFile = "/run/keys/wireless";
        networks = {
          "SFR_7100" = {
            psk = "@PSK_SFR_2GHZ@";
            priority = 9;
          };
          "SFR_7100_5GHZ" = {
            psk = "@PSK_SFR_5GHZ@";
            priority = 10;
          };
          "Majok" = {
            psk = "@PSK_MAJOK@";
            priority = 100;
          };
          "CAMPUS-NUMERIQUE" = {
            psk = "@PSK_CAMPUS@";
            priority = 3;
          };
          "floki_office_plus" = {
            psk = "@PSK_FLOKI@";
            priority = 5;
          };
          "floki_office" = {
            psk = "@PSK_FLOKI@";
            priority = 4;
          };
          "Bbox-9A77B139" = {
            psk = "@PSK_MONICA@";
            priority = 10;
          };
        };

        # Imperative networks (manually selectable)
        allowAuxiliaryImperativeNetworks = true;
        userControlled = {
          enable = true;
          group = "network";
        };
      };

  };

  # Ensure the network group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
