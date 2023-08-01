{ pkgs, ... }:

# nnn	Configuration
# Small ncurses-based file browser forked from noice

let
  customLib = import ./../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/nnn";

  nnn_withIcons = pkgs.nnn.override ({ withNerdIcons = true; });

in
{

  # generate the script to stow nnn's configuration files
  home.file."stow_dotfiles/stow_nnn.sh" = {
    text = stow_script;
    executable = true;
  };

  programs.nnn = {
    enable = true;
    package = nnn_withIcons;

    extraPackages = with pkgs; [
      # preview-tui
      less            # A more advanced file pager than ‘more’
      tree            # Command to produce a depth indented directory listing
      mediainfo       # Supplies technical and tag information about a video or audio file
      mktemp          # Simple tool to make temporary file handling in shells scripts safe and simple
      unzip           # An extraction utility for archives compressed in .zip format
      man             # An implementation of the standard Unix documentation system accessed using the man command
      bat             # A cat(1) clone with syntax highlighting and Git integration
      viu             # A command-line application to view images from the terminal written in Rust
      imagemagick			# A software suite to create, edit, compose, or convert bitmap images
      ffmpegthumbnailer  # A lightweight video thumbnailer
      ffmpeg          # A complete, cross-platform solution to record, convert and stream audio and video
      libreoffice-qt	# Comprehensive, professional-quality productivity suite
      poppler_utils   # A PDF rendering library
      fontpreview     # Highly customizable and minimal font previewer written in bash
      djvulibre       # The big set of CLI tools to make/modify/optimize/show/export DJVU files
      glow            # Render markdown on the CLI, with pizzazz!
      w3m             # A text-mode web browser
      pistol          # General purpose file previewer designed for Ranger, Lf to make scope.sh redundant
      kitty           # A modern, hackable, featureful, OpenGL based terminal emulator
      # launcher
      fzf             # A command-line fuzzy finder written in Go
      # drag-and-drop
      xdragon         # Simple drag-and-drop source/sink for X 
    ];

    plugins = {
      src = (pkgs.fetchFromGitHub {
          owner = "jarun";
          repo = "nnn";
          rev = "v4.0";
          sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
          }) + "/plugins";
    };
  };

  programs.zsh.initExtra = ''
      # nnn extra configuration
      [ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
      alias N='sudo -E nnn -dH'
      source ~/.config/nnn/nnn_env_vars.sh
      source ~/.config/nnn/quitcd.bash_zsh.sh
      echo "initExtra: nnn config loaded!"
  '';

  programs.zsh.profileExtra = ''
      # nnn extra configuration
      [ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
      alias N='sudo -E nnn -dH'
      source ~/.config/nnn/nnn_env_vars.sh
      source ~/.config/nnn/quitcd.bash_zsh.sh
      echo "initExtra: nnn config loaded!"
  '';

  xdg = {
    desktopEntries = {
      nnn = {
        name = "nnn";
        genericName = "not noice";
        comment = "Terminal file manager";
        exec = "nnn";
        type = "Application";
        icon = toString ./dotfiles/nnn/logo-64x64.png;
        terminal = true;
        categories = ["System" "FileTools" "FileManager" "ConsoleOnly"];
        mimeType = ["inode/directory"];
      };
    };
  };


  
}

