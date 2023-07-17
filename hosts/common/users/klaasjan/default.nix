{ pkgs, ... }:

{

  users.users.klaasjan = {
    home = "/home/klaasjan";
    initialPassword = "admin";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "network" ];
  };

  programs.zsh.enable = true;

}
