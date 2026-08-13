{ pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia/default.nix
    ./wireless.nix

    ../common/global

    # ../common/optional/nixops.nix
    ../common/optional/hyprland.nix
    ../common/optional/obsstudio.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/thunar.nix # Graphical File Manager
    ../common/optional/virtualisation/docker.nix
    ../common/optional/virtualisation/libvirt-kvm.nix
    ../common/optional/xdg.nix

    ../common/users/klaasjan
  ];

  # Permitted Insecure Packages
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-59-6.18.43"
  ];

  # Unfree Packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # WiFi driver
      "broadcom-sta"

      # Social media
      "discord"

      # NVIDIA drivers
      "nvidia"
      "nvidia-x11"
      "nvidia-settings"
      "nvidia-kernel-modules"

      # A compiler for NVIDIA GPUs, math libraries, and tools
      "cudatoolkit"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvcc"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cccl"
      "cuda_cudart"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcublas"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libnpp"

      # other tools
      "drawio"

      # steam
      # "steam"
      # "steam-unwrapped"
      # "steam-original"
      # "steam-run"
    ];

  programs.steam = {
    enable = false;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
      extraEntries = ''
        menuentry "Reboot" {
          reboot
        }
        menuentry "Poweroff" {
          halt
        }
      '';
    };
  };

  security.rtkit.enable = true;

  security.polkit.enable = true;
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # ToDo restart geoclue service after wpa_supplicant
  services.geoclue2.enable = true;

  # Needed to unlock swaylock
  # https://discourse.nixos.org/t/swaylock-wont-unlock/27275
  security.pam.services = {
    swaylock = { };
  };

  # What happens when the laptop's lid is closed
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "suspend";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl # This program allows you read and control device brightness

    cachix # Command-line client for Nix binary cache hosting https://cachix.org

    # INFO: if you get the following error on wayland: "Gtk-WARNING **: 15:25:24.921: cannot open display: :0", run:
    # $sudo -EH gparted
    # more info: https://unix.stackexchange.com/a/423287
    gparted # Graphical disk partitioning tool

  ];

  services.flatpak.enable = true;

  services.dolibarr = {
    enable = false;
    nginx = null;
    domain = "127.0.0.1";
    # preInstalled = true;
    # initialDbPasswordFile = "/run/keys/dolibarr-db-ini-password";
  };

  services.open-webui.enable = false;

  environment.variables = {
    EDITOR = "nvim";
  };

  system.stateVersion = "22.05";

}
