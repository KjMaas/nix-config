{ pkgs, ... }:

{

  imports = [
    ./fonts.nix
  ];

  home.packages = with pkgs; [ 
    stow
  ];

  # Add environment variable to locate the root folder for
  # Home Manager's configuration files
  home.sessionVariables = {
    HOME_MANAGER_CONFIG_DIR = "$HOME/Documents/nix-config/home";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.file.".local/bin/stow_dotfiles.sh" = {
    text = ''
      #!/usr/bin/env bash
      echo ""
      echo "stowing dotfiles..."
      echo "###################"
      cd $HOME/stow_dotfiles/
      find . -type l -name "*.sh" -exec bash {} \;
      echo "done"
      echo "####"
      echo ""
    '';
    executable = true;
  };

}
