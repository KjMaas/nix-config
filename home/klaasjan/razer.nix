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
    # Development Environment
    ../common/optional/nvim
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

# Nord theme:
# base00 #2E3440;
# base01 #3B4252;
# base02 #434C5E;
# base03 #4C566A;
# base04 #D8DEE9;
# base05 #E5E9F0;
# base06 #ECEFF4;
# base07 #8FBCBB;
# base08 #BF616A;
# base09 #D08770;
# base0A #EBCB8B;
# base0B #A3BE8C;
# base0C #88C0D0;
# base0D #81A1C1;
# base0E #B48EAD;
# base0F #5E81AC;

