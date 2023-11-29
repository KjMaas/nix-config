{ pkgs, inputs, ... }:

let
  pkgs-unfree = import inputs.nixpkgs {
    system = pkgs.system;
    config.allowUnfree = true;
  };

in
{
  programs.vscode = {
    # ... no comments please, it's for research
    enable = true;
    
    # ToDo: make the Blender-Development plugin work in VsCodium
    # package = pkgs.vscodium;
    package = pkgs-unfree.vscode;

    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      asvetliakov.vscode-neovim
      yzhang.markdown-all-in-one
    ];
  };

}
