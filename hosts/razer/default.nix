{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./wireless.nix
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

  environment.systemPackages = with pkgs; [

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

  users.users.klaasjan = {
    home = "/home/klaasjan";
    initialPassword = "admin";
    isNormalUser = true;
    extraGroups = [ "wheel" "network" ];
  };

  environment.variables = {
    EDITOR = "nvim";
  };
  
  system.stateVersion = "22.05";

}
