{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
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
    ../common/optional/ghostty

    # Development Environment
    ../common/optional/nvim
    ../common/optional/zed
    # ../common/optional/vscode

    # File Explorers
    # ../common/optional/nnn

    # Office suite
    ../common/optional/libreoffice

    # Cloud storage
    ../common/optional/rclone

    # Applications
    # ../common/optional/etcher     # Flash OS on SD and USB --- Etcher has been deprecated for security reasons (Electron-related)
    ../common/optional/flameshot # Powerful yet simple to use screenshot software
    ../common/optional/obsstudio # video recording and live streaming
    ../common/optional/vimiv # Image viewer
    ../common/optional/zathura # PDF viewer
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
      GTK_BACKEND = "wayland,x11";

      # X Desktop Group Variables (freedesktop.org)
      XDG_SESSION_TYPE = "wayland";
    };

  };

  home.packages = with pkgs; [
    # terminal
    foot # Fast, lightweight and minimalistic Wayland terminal emulator

    # Display and screen sharing
    wdisplays # A graphical application for configuring displays in Wayland compositors

    # 3D stuff
    blender_4_4
    f3d # Fast and minimalist 3D viewer using VTK

    # browser
    brave # Privacy-oriented browser for Desktop and Laptop computers
    # chromium # An open source web browser from Google
    # epiphany # WebKit based web browser for GNOME
    firefox # A web browser built from Firefox source tree

    # file managers
    spacedrive # Open source file manager, powered by a virtual distributed filesystem
    superfile # Pretty fancy and modern terminal file manager

    # Multimedia
    audacity # Sound editor with graphical UI
    vlc # Cross-platform media player and streaming server
    gimp3-with-plugins # GNU Image Manipulation Program

    # Cloud
    keepassxc # Offline password manager with many features.

    # Tools
    mesa-demos # Test utilities for OpenGL
    baobab # Graphical application to analyse disk usage
    arp-scan # ARP scanning and fingerprinting tool
    dbeaver-bin # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
    kdePackages.qtwayland # Cross-platform application framework for C++
    qt6.qtwayland

    # Utility Apps
    poppler-utils # A PDF rendering library
    imagemagick # A software suite to create, edit, compose, or convert bitmap images
    pdfsam-basic # Multi-platform software designed to extract pages, split, merge, mix and rotate PDF files
    ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
    mpv # General-purpose media player, fork of MPlayer and mplayer2

    # Social media
    signal-desktop # Private, simple, and secure messenger (nixpkgs build)
    wasistlos # Unofficial WhatsApp desktop application

    # Development
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
    insomnia # The open-source, cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
    # uv # Extremely fast Python package installer and resolver, written in Rust

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
