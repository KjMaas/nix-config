{ lib, ... }:

{

  imports = [
    ../zsh
  ];

  programs.kitty = {
    enable = true;
    settings = {
      shell_integration = "enabled";
    };

    # load native (not nixified) configuration file
    extraConfig = ''
      include /home/klaasjan/Documents/nix-config/${ with lib;
        strings.concatStringsSep "/" (
            lists.drop 4 (
              strings.splitString "/" (toString ./kitty.conf)
              )
            )
      }
    '';
  };

}
