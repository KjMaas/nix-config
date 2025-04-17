{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  customLib = import ./../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/zed";

  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };

in
{
  home.shellAliases = {
    zed = "zeditor";
  };

  # generate the script to stow zed's configuration files
  home.file."stow_dotfiles/stow_zed.sh" = {
    text = stow_script;
    executable = true;
  };

  home.packages = with pkgs; [
    # zed package
    unstable.zed-editor # High-performance, multiplayer code editor from the creators of Atom and Tree-sitter

    # git
    lazygit # Simple terminal UI for git commands

    # Nix
    nixfmt-rfc-style # Official formatter for Nix code
    nixd # Nix language server

  ];

}
