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

    # Desktop
    ../common/optional/gnome
    # Shell
    ../common/optional/zsh
    # Versioning
    ../common/optional/git
    # Window Manager - uses the Wayland compositor
    ../common/optional/wayland/hyprland
    ../common/optional/kitty
    # Development Environment
    ../common/optional/nvim
    ../common/optional/vscode
    # File Explorers
    ../common/optional/nnn
    # Office suite
    ../common/optional/libreoffice
    # Cloud storage
    ../common/optional/rclone
    # Applications
    ../common/optional/etcher     # Flash OS on SD and USB
    ../common/optional/obsstudio  # video recording and live streaming
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
    wdisplays   # A graphical application for configuring displays in Wayland compositors

    # 3D stuff
    blender_4_0
    f3d # Fast and minimalist 3D viewer using VTK


    # browser
    brave           # Privacy-oriented browser for Desktop and Laptop computers
    chromium        # An open source web browser from Google
    epiphany        # WebKit based web browser for GNOME
    firefox         # A web browser built from Firefox source tree
    microsoft-edge  # The web browser from Microsoft

    # Multimedia
    audacity                  # Sound editor with graphical UI
    vlc                       # Cross-platform media player and streaming server

    # Cloud
    keepassxc       # Offline password manager with many features.

    # Tools
    glxinfo         # Test utilities for OpenGL
    baobab          # Graphical application to analyse disk usage
    unstable.angryipscanner  # Angry IP Scanner - fast and friendly network scanner
    drawio          # A desktop application for creating diagrams
    dbeaver         # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more

    # Utility Apps
    poppler_utils   # A PDF rendering library
    imagemagick     # A software suite to create, edit, compose, or convert bitmap images
    pdfsam-basic    # Multi-platform software designed to extract pages, split, merge, mix and rotate PDF files
    ffmpeg          # A complete, cross-platform solution to record, convert and stream audio and video
    davinci-resolve # Professional video editing, color, effects and audio post-processing

    # Social media
    unstable.signal-desktop  # Private, simple, and secure messenger

    # Gaming
    yuzu-mainline   # The mainline branch of an experimental Nintendo Switch emulator written in C++
    mupen64plus     # A Nintendo 64 Emulator

  ];

  services.flameshot = {
    enable = true;
    settings = {
      # General = {
      #   disabledTrayIcon = true;
      #   showStartupLaunchMessage = false;
      # };
    };
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

