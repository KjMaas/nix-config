{ config, pkgs, ... }: {

  imports = [
    ./common
  ];

  home = {
    stateVersion = "23.05";

    username = "klaasjan";
    homeDirectory = "/home/klaasjan";

    packages = with pkgs; [
        cowsay
    ];


  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  services = {
    flameshot.enable = true;
  };

}

