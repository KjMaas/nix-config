{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ../common/global

    # Shell
    ../common/optional/zsh
    # Versioning
    ../common/optional/git
    # Window Manager - uses the Wayland compositor
    ../common/optional/wayland/hyprland
    ../common/optional/kitty
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  home = {
    username = "klaasjan";
    homeDirectory = "/home/klaasjan";
    stateVersion = "22.05";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
