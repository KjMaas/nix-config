{ pkgs }:

{
  imports = [
    ../common/global

    ../common/optional/wayland/hyprland
    ../common/optional/zsh
    ../common/optional/kitty
  ];

  home = {
    username = "klaasjan";
    homeDirectory = "/home/klaasjan";
    stateVersion = "22.05";

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "Klaasjan Maas";
    userEmail = "klaasjan.maas@outlook.com";
    aliases = {
      graph = "log --decorate --oneline --graph";
    };
    extraConfig = {
      init.defaultBranch = "main";
    };
    ignores = [ ".direnv" "result" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
