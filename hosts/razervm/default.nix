{ inputs, outputs, lib, config, pkgs, ... }: 

{
  imports = [
    # Import the generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    # common configurations to all the machines
    ../common/global
    # optional configurations
    ../common/optional/xserver.nix
    # ../common/optional/desktops/gnome.nix
    # user-specific configurations
    ../common/users/klaasjan
  ];

  environment.systemPackages = with pkgs; [
    pciutils        # Programs for inspecting and manipulating configuration of PCI devices
    unzip           # An extraction utility for archives compressed in .zip format

    tree            # Command to produce a depth indented directory listing
    wget            # Tool for retrieving files using HTTP, HTTPS, and FTP
    bat             # A cat(1) clone with syntax highlighting and Git integration
    neovim          # The most popular clone of the VI editor
    htop-vim        # An interactive process viewer for Linux, with vim-style keybindings

    firefox-bin     # Mozilla Firefox, free web browser (binary package)
  ];

  networking = {
    networkmanager.enable = true;
    hostName = "razervm";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
