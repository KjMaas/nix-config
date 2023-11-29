{ pkgs, ... }:

{

  programs.vscode = {
    # ... no comments please, it's for research
    enable = true;
    
    # ToDo: make the Blender-Development plugin work in VsCodium
    # package = pkgs.vscodium;

    extensions = with pkgs.vscode-extensions; [
      arcticicestudio.nord-visual-studio-code
      asvetliakov.vscode-neovim
      yzhang.markdown-all-in-one
    ];
  };

}
