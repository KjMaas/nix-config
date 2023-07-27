{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ../common/global

    ../common/optional/wayland/hyprland
    # Shell
    ../common/optional/zsh
    # Versioning
    ../common/optional/git
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
