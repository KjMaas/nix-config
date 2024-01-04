{ config, ... }:

{

  # Wireless secrets stored and provisioned with sops
  sops.secrets.wireless = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
    restartUnits = [ "wpa_supplicant.service" ];
  };

  networking = {

      hostName = "razer";

      networkmanager.enable = false; # Easiest to use and most distros use this by default.

      wireless = {
        enable = true; # Enables wireless support via wpa_supplicant.

        # Declarative networks
        environmentFile = config.sops.secrets.wireless.path;
        networks = {
          "@HOME_01_SSID@" = {
            psk = "@HOME_01_PSK@";
            priority = 20;
          };
          "@HOME_02_SSID@" = {
            psk = "@HOME_02_PSK@";
            priority = 19;
          };
          "@ROAMING_01_SSID@" = {
            psk = "@ROAMING_01_PSK@";
            priority = 100;
          };
          "@ROAMING_02_SSID@" = {
            psk = "@ROAMING_02_PSK@";
            priority = 99;
          };
          "@WORK_01_SSID@" = {
            psk = "@WORK_01_PSK@";
            priority = 5;
          };
          "@WORK_02_SSID@" = {
            psk = "@WORK_02_PSK@";
            priority = 5;
          };
          "@WORK_03_SSID@" = {
            psk = "@WORK_03_PSK@";
            priority = 5;
          };
          "@INVITE_01_SSID@" = {
            psk = "@INVITE_01_PSK@";
            priority = 10;
          };
          "@INVITE_05_SSID@" = {
            psk = "@INVITE_05_PSK@";
            priority = 10;
          };
          "@INVITE_06_SSID@" = {
            psk = "@INVITE_06_PSK@";
            priority = 10;
          };
          "@INVITE_07_SSID@" = {
            psk = "@INVITE_07_PSK@";
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
