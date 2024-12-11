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

    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    wireless = {
      enable = false; # Enables wireless support via wpa_supplicant.

      # Declarative networks
      # FIX: parsing network SSIDs from the config file no longer works:
      # https://discourse.nixos.org/t/wireless-network-configuration-parameters-hidding/54935/5
      secretsFile = config.sops.secrets.wireless.path;
      networks = {
        "@HOME_01_SSID@" = {
          psk = "ext:HOME_01_PSK";
          priority = 20;
        };
        "@HOME_02_SSID@" = {
          psk = "ext:HOME_02_PSK";
          priority = 19;
        };
        "@ROAMING_01_SSID@" = {
          psk = "ext:ROAMING_01_PSK";
          priority = 100;
        };
        "@ROAMING_02_SSID@" = {
          psk = "ext:ROAMING_02_PSK";
          priority = 99;
        };
        "@WORK_01_SSID@" = {
          psk = "ext:WORK_01_PSK";
          priority = 5;
        };
        "@WORK_02_SSID@" = {
          psk = "ext:WORK_02_PSK";
          priority = 5;
        };
        "@WORK_03_SSID@" = {
          psk = "ext:WORK_03_PSK";
          priority = 5;
        };
        "@INVITE_01_SSID@" = {
          psk = "ext:INVITE_01_PSK";
          priority = 10;
        };
        "@INVITE_05_SSID@" = {
          psk = "ext:INVITE_05_PSK";
          priority = 10;
        };
        "@INVITE_06_SSID@" = {
          psk = "ext:INVITE_06_PSK";
          priority = 10;
        };
        "@INVITE_07_SSID@" = {
          psk = "ext:INVITE_07_PSK";
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
