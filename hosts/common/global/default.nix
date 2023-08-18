# These configs are common to all the hosts
{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./locale.nix
    ./nix.nix
    ./openssh.nix
    ./opengl.nix
    ./security.nix
    ./sops.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = false; # manually chose which unfree packages are installed on each host
    };
  };

  hardware.enableRedistributableFirmware = true;

  # backlight
  programs.light.enable = true;

  # Graphical File Manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  # Mount, trash, and other functionalities
  services.gvfs.enable = true;
  # Thumbnail support for images
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    trash-cli # Command line interface to the freedesktop.org trashcan
    powertop  # Analyze power consumption on Intel-based laptops
  ];

  # Regulate power consumption 
  powerManagement.powertop.enable = true;

}
