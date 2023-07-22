{ pkgs, inputs, lib, ... }:

{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ../../kitty
  ];

  # load native (not nixified) configuration file
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source=/home/klaasjan/Documents/nix-config/${ with lib;
        strings.concatStringsSep "/" (
          lists.drop 4 (
            strings.splitString "/" (toString ./hyprland.conf)
          )
        )
      }
    '';
  };

  # add script folder @ ~/.config/hypr/scripts/...
  xdg.configFile."scripts" = {
      enable = true;
      executable = true;
      recursive = true;
      source = ./scripts;
      target = "./hypr/scripts/";
  };

  home.packages = with pkgs; [ 
    brave         # Privacy-oriented browser for Desktop and Laptop computers
    # screenshots
    grim          # Grab images from a Wayland compositor
    slurp         # Select a region in a Wayland compositor
    swappy        # A Wayland native snapshot editing tool
  ];

}
