{ pkgs, inputs,... }:

let
  customLib = import ./../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/nvim";

  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

in
{
  home.shellAliases = {
    v = "nvim";
  };

  # generate the script to stow neovim's configuration files
  home.file."stow_dotfiles/stow_nvim.sh" = {
    text = stow_script;
    executable = true;
  };

  programs.neovim = {
    enable = true;

    withPython3 = true;
    withNodeJs = true;
    withRuby = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # External apps needed to process text inputs from neovim
      # ToFix: package already installed if [...]/common/global/mime.nix is sourced
      mimeo         # Open files by MIME-type or file name using regular expressions
      jq            # A lightweight and flexible command-line JSON processor

      # required for the telescope plugin
      ripgrep       # A utility that combines the usability of The Silver Searcher with the raw speed of grep

      # other
      neovim-remote # A tool that helps controlling nvim processes from a terminal

      # Bash
      nodePackages.bash-language-server
      shellcheck

      # lua
      luajitPackages.luarocks # A package manager for Lua
      stylua                  # An opinionated Lua code formatter
      luaformatter
      lua-language-server     # A language server that offers Lua language support

      # HTML/CSS/JS
      nodePackages.vscode-langservers-extracted
      prettierd # Prettier, as a daemon, for improved formatting speed

      # JavaScript
      nodePackages.typescript-language-server

      # Make
      cmake-language-server

      # Markdown
      nodePackages.markdownlint-cli

      # Nix
      nil
      # ToCheck: has been merged with stable?
      unstable.nixd
      deadnix
      statix

      # python
      python3Packages.isort
      nodePackages.pyright
      black
      python3Packages.flake8
      mypy

      # Rust
      cargo

      # Required to compile Treesitter parsers (can also be gcc, clang or any other c compiler)
      zig # General-purpose programming language and toolchain for maintaining robust, optimal, and reusable software

      # AI assistant
      # ToCheck: has been merged with stable?
      unstable.codeium # Codeium language server
      # manual setup is required for Codeium:
      # $ln -s "$(which codeium_language_server)" "/home/klaasjan/.local/share/.codeium/bin/3dee3c5d9fe70aff1993c1a94c1c2bb3c2de5df9/language_server_linux_x64"

    ];

    # source not nixified neovim configuration
    extraConfig = 
      ''
      luafile ${builtins.toString /home/klaasjan/.config/nvim/init_lua.lua}
      '';

  };

  # Configure which file types are opened with NeoVim by default
  xdg.desktopEntries.nvim = {
    name = "NeoVim";
    genericName = "Awesome Text Editor";
    comment = "Edit text files";
    exec = "nvim %F";
    icon = "nvim";
    mimeType = [
      "application/json"
      "application/javascript"
      "application/toml"
      "application/x-shellscript"
      "text/css"
      "text/english"
      "text/markdown"
      "text/plain"
      "text/x-log"
      "text/x-makefile"
      "text/x-python3"
      "text/x-tex"
    ];
    terminal = true;
    type = "Application";
    categories = [ "Utility" "TextEditor" ];
  };

}
