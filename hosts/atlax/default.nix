{
  pkgs,
  lib,
  config,
  ...
}:

let
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
  ) pkgs.linuxKernel.packages;

  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );

in
{
  imports = [
    # ./hardware-configuration.nix
    ./disk-config.nix
    ./wireless.nix

    ../common/global

    ../common/optional/iso.nix
    # ../common/optional/hyprland.nix
    ../common/optional/kde.nix
    # ../common/optional/obsstudio.nix
    ../common/optional/pipewire.nix
    # ../common/optional/printing.nix
    ../common/optional/thunar.nix # Graphical File Manager
    # ../common/optional/virtualisation/docker.nix
    ../common/optional/virtualisation/libvirt-kvm.nix
    # ../common/optional/xdg.nix

    ../common/users/klaasjan

  ];

  boot = {
    kernelModules = [ "kvm-amd" ]; # Use "kvm-amd" for AMD CPUs
    kernelPackages = latestKernelPackage;
    supportedFilesystems = [ "zfs" ];
    initrd.kernelModules = [ "zfs" ];
    loader = {
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
  security.pam.services = {
    swaylock = { };
  };

  # Unfree Packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # WiFi driver
      "vault-bin"
    ];

  environment.systemPackages = with pkgs; [

    cachix # Command-line client for Nix binary cache hosting https://cachix.org

    # INFO: if you get the following error on wayland: "Gtk-WARNING **: 15:25:24.921: cannot open display: :0", run:
    # $sudo -EH gparted
    # more info: https://unix.stackexchange.com/a/423287
    gparted # Graphical disk partitioning tool

  ];

  services.flatpak.enable = true;

  environment.variables = {
    EDITOR = "nvim";
  };

  programs = {
    firefox.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  system.stateVersion = "25.11";
}

# copying path '/nix/store/9ka765z8z8a9p6xdq5a8iq9dsds4ybbf-etc-modprobe.d-firmware.conf' from 'https://cache.nixos.org'...
# ### Installing NixOS ###
# Pseudo-terminal will not be allocated because stdin is not a terminal.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# installing the boot loader...
# setting up secrets for users...
# Cannot read ssh key '/etc/ssh/ssh_host_ed25519_key': open /etc/ssh/ssh_host_ed25519_key: no such file or directory
# /nix/store/pa8j1j0p9phln462llhjxd4xkldcl46w-sops-install-secrets-0.0.1/bin/sops-install-secrets: Failed to decrypt '/nix/store/0hdvk2r3i72vbrz2v8z6bj20ni84mpkb-secrets.yaml': Error getting data key: 0 successful groups required, got 0
# Activation script snippet 'setupSecretsForUsers' failed (1)
# warning: password file ‘/run/secrets-for-users/klaasjan-password’ does not exist
# setting up /etc...
# Warning: do not know how to make this configuration bootable; please enable a boot loader.
# installation finished!
# ### Rebooting ###
# Pseudo-terminal will not be allocated because stdin is not a terminal.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# umount: /mnt/persist (zroot/root/persist) unmounted
# umount: /mnt/nix (zroot/root/nix) unmounted
# umount: /mnt/media (zroot/root/media) unmounted
# umount: /mnt/home (zroot/root/home) unmounted
# umount: /mnt/boot unmounted
# umount: /mnt (zroot/root) unmounted
# ### Waiting for the machine to become unreachable due to reboot ###
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# Warning: Permanently added 'nixos' (ED25519) to the list of known hosts.
# ssh: connect to host nixos port 22: Connection refused
# ### Done! ###

# klaasjan@razer took 16m0s
