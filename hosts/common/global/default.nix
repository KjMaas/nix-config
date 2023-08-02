# These configs are common to all the hosts
{ pkgs, ... }:

{
  imports = [
    ./locale.nix
    ./nix.nix
    ./openssh.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
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

  environment.systemPackages = [
    pkgs.trash-cli # Command line interface to the freedesktop.org trashcan
  ];

}
