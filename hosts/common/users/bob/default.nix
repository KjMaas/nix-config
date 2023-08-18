{ pkgs, config, ... }:

{
  sops.secrets.bob-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;

  users.users.bob = {
    home = "/home/bob";
    initialPassword = "admin";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"     # sudo
      "network"   # members of this group are able to set up networks through wpa_cli or wpa_gui
      "video"     # needed for display modification, including brightness control
    ];
  };

  programs.zsh.enable = true;

}
