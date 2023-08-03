{ pkgs, lib, ... }:

let 
  nixops_unstable_override = pkgs.nixops_unstable.override {
    overrides = (self: super: {
      nixopsvbox = super.nixopsvbox.overridePythonAttrs (
        _: {
          src = pkgs.fetchgit {
            url = "https://github.com/KjMaas/nixops-vbox.git";
            rev = "6db55874a3d426c07b4dc957a08678417efa0ca6";
            sha256 = "sha256-ssNYLdkehhuBBZ+GuDq8wFq87zGnog+56wJP/Q/6ruc=";
          };
        }
      );
    });
  };

in
{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./wireless.nix

    ../common/global

    ../common/optional/pipewire.nix
    # ../common/optional/hyprland.nix
    ../common/optional/xdg.nix

    ../common/users/klaasjan
  ];

  # Unfree Packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # WiFi driver
      "broadcom-sta"
      # NVIDIA drivers
      "nvidia-x11"
      "nvidia-settings"
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

  # ToDo restart geoclue service after wpa_supplicant
  services.geoclue2.enable = true;  

  # Needed to unlock swaylock
  # https://discourse.nixos.org/t/swaylock-wont-unlock/27275
  security.pam.services = { swaylock = { }; };

  };

  environment.systemPackages = with pkgs; [

    nixops_unstable_override  # NixOS cloud provisioning and deployment tool

    firefox         # A web browser built from Firefox source tree

    neovim          # The most popular clone of the VI editor
    bat             # A cat(1) clone with syntax highlighting and Git integration
    htop-vim        # An interactive process viewer for Linux, with vim-style keybindings
    tree            # Command to produce a depth indented directory listing
    unzip           # An extraction utility for archives compressed in .zip format
    wget            # Tool for retrieving files using HTTP, HTTPS, and FTP
    pciutils        # Programs for inspecting and manipulating configuration of PCI devices
    lshw            # Provide detailed information on the hardware configuration of the machine
    nmap            # Utility for network discovery and security auditing

  ];

  environment.variables = {
    EDITOR = "nvim";
  };
  
  system.stateVersion = "22.05";

}
