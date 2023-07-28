{ pkgs, ... }:

let
  customLib = import ./../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/nvim";

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
      neovim-remote # A tool that helps controlling nvim processes from a terminal

      # Bash
      nodePackages.bash-language-server
      shellcheck

      # lua
      luajitPackages.luarocks # A package manager for Lua
      stylua                  # An opinionated Lua code formatter
      luaformatter
      sumneko-lua-language-server

      # HTML/CSS/JS
      nodePackages.vscode-langservers-extracted

      # JavaScript
      nodePackages.typescript-language-server

      # Make
      cmake-language-server

      # Markdown
      nodePackages.markdownlint-cli

      # Nix
      nil
      # nixd
      # rnix-lsp
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
    ];

    extraConfig = 
      ''

      -- source not nixified neovim configuration
      luafile ${builtins.toString /home/klaasjan/.config/nvim/init_lua.lua}
      '';

  };

}
