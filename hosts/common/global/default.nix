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

  environment.systemPackages = with pkgs; [
    trash-cli # Command line interface to the freedesktop.org trashcan
    powertop  # Analyze power consumption on Intel-based laptops
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
