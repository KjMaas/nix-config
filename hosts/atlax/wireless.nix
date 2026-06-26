{ config, lib, ... }:

{

  # Wireless secrets stored and provisioned with sops
  sops.secrets.wireless = {
    sopsFile = ../common/secrets.yaml;
    neededForUsers = true;
    restartUnits = [ "wpa_supplicant.service" ];
  };

  networking = {

    hostName = "atlax";
    hostId = "73b15d6c"; # generated with the cmd: `head -c4 /dev/urandom | od -A none -t x4`

    networkmanager = {
      enable = true;
      ensureProfiles = {
        environmentFiles = [ config.sops.secrets.wireless.path ];
        profiles = {
          home = {
            connection.id = "home-01";
            connection.type = "wifi";
            wifi.ssid = "$HOME_01_SSID";
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "$HOME_01_PSK";
            };
          };
          roaming = {
            connection.id = "roaming";
            connection.type = "wifi";
            wifi.ssid = "Majok";
            wifi-security = {
              auth-alg = "open";
              key-mgmt = "wpa-psk";
              psk = "temporary";
            };
          };
        };
      };
    };

    # # Firewall
    # firewall.checkReversePath = false;

    # wireless = {
    #   enable = lib.mkForce true; # Enables wireless support via wpa_supplicant.

    #   # Declarative networks
    #   # FIX: parsing network SSIDs from the config file no longer works:
    #   # https://discourse.nixos.org/t/wireless-network-configuration-parameters-hidding/54935/5
    #   secretsFile = config.sops.secrets.wireless.path;
    #   networks = {
    #     "@HOME_01_SSID@" = {
    #       psk = "ext:HOME_01_PSK";
    #       priority = 20;
    #     };
    #     "Majok" = {
    #       psk = "temporary";
    #       priority = 50;
    #     };
    #   };

    #   # Imperative networks (manually selectable)
    #   allowAuxiliaryImperativeNetworks = true;
    #   userControlled = {
    #     enable = true;
    #     group = "network";
    #   };
    # };

  };

  # Ensure the network group exists
  users.groups.network = { };

  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
