# These configs are common to all the hosts
{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./locale.nix
    ./nix.nix
    ./opengl.nix
    ./openssh.nix
    ./security.nix
    ./sops.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = false; # manually chose which unfree packages are installed on each host
    };
  };

  hardware.enableRedistributableFirmware = true;

  environment.systemPackages = with pkgs; [
    bat       # A cat(1) clone with syntax highlighting and Git integration
    fd        # A simple, fast and user-friendly alternative to find
    firefox   # A web browser built from Firefox source tree
    htop-vim  # An interactive process viewer for Linux, with vim-style keybindings
    lshw      # Provide detailed information on the hardware configuration of the machine
    nmap      # Utility for network discovery and security auditing
    pciutils  # Programs for inspecting and manipulating configuration of PCI devices
    powertop  # Analyze power consumption on Intel-based laptops
    trash-cli # Command line interface to the freedesktop.org trashcan
    tree      # Command to produce a depth indented directory listing
    unzip     # An extraction utility for archives compressed in .zip format
    wget      # Tool for retrieving files using HTTP, HTTPS, and FTP
  ];

  # Regulate power consumption 
  powerManagement.powertop.enable = true;

  # make NeoVim the default editor when root
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
  };

}
