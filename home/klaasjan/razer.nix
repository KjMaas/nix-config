{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

in
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
    # File Explorers
    ../common/optional/nnn
    # Office suite
    ../common/optional/libreoffice
    # Cloud storage
    ../common/optional/rclone
    # Applications
    ../common/optional/etcher     # Flash OS on SD and USB
    ../common/optional/vimiv      # Image viewer
    ../common/optional/zathura    # PDF viewer
  ];

  colorScheme = inputs.nix-colors.colorSchemes.nord;

  home = {
    username = "klaasjan";
    homeDirectory = "/home/klaasjan";
    stateVersion = "22.05";

    sessionVariables = {
      BROWSER = "brave";
      TERMINAL = "kitty";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";

      # Set prefered video card (iGPU or dGPU)
      # $ lspci | grep -E 'VGA|3D'
      # $ ls -al /dev/dri/by-path
      # card0 = AMD
      # card1 = Nvidia
      WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";

      # GTK: Use wayland if available, fall back to x11 if not.
      GTK_BACKEND="wayland,x11";

      # X Desktop Group Variables (freedesktop.org)
      XDG_SESSION_TYPE = "wayland";
    };

  };

  home.packages = with pkgs; [

    # Display and screen sharing
    wdisplays                 # A graphical application for configuring displays in Wayland compositors

    # 3D stuff
    blender_3_6 # ToDo: create a custom Desktop entry that launches Blender with `nvidia-offload`
    f3d # Fast and minimalist 3D viewer using VTK


    # browser
    brave  # Privacy-oriented browser for Desktop and Laptop computers

    # Multimedia
    obs-studio                # Free and open source software for video recording and live streaming
    obs-studio-plugins.wlrobs # An obs-studio plugin that allows you to screen capture on wlroots based wayland compositors
    # Cloud
    keepassxc       # Offline password manager with many features.
  ];

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

