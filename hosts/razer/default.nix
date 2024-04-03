{ pkgs, lib, ... }:


{
  imports = [
    ./hardware-configuration.nix
    ./nvidia/default.nix
    ./wireless.nix

    ../common/global

    # ../common/optional/nixops.nix
    ../common/optional/obsstudio.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/thunar.nix     # Graphical File Manager
    ../common/optional/virtualisation/docker.nix
    ../common/optional/virtualisation/libvirt-kvm.nix
    ../common/optional/xdg.nix

    ../common/users/klaasjan
  ];

  # Unfree Packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # WiFi driver
      "broadcom-sta"

      # NVIDIA drivers
      "nvidia"
      "nvidia-x11"
      "nvidia-settings"

      # A compiler for NVIDIA GPUs, math libraries, and tools
      "cudatoolkit"

      # needed to install Edge
      "microsoft-edge-stable"
    ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-19.1.9" # Cross platform desktop application shell (needed for Balena Etcher)
  ];

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

  # backlight
  programs.light.enable = true;

  # ToDo restart geoclue service after wpa_supplicant
  services.geoclue2.enable = true;  

  # Needed to unlock swaylock
  # https://discourse.nixos.org/t/swaylock-wont-unlock/27275
  security.pam.services = { swaylock = { }; };

  # What happens when the laptop's lid is closed
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "suspend";
  };

  environment.systemPackages = with pkgs; [

    # INFO: if you get the following error on wayland: "Gtk-WARNING **: 15:25:24.921: cannot open display: :0", run:
    # $sudo -EH gparted
    # more info: https://unix.stackexchange.com/a/423287
    gparted         # Graphical disk partitioning tool

  ];

  environment.variables = {
    EDITOR = "nvim";
  };
  
  system.stateVersion = "22.05";

}
