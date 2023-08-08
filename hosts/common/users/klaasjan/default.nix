{ pkgs, config, ... }:

{
  sops.secrets.klaasjan-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;

  users.users.klaasjan = {
    home = "/home/klaasjan";
    # initialPassword = "admin";
    passwordFile = config.sops.secrets.klaasjan-password.path; # copy output of $ mkpasswd -m yescryp
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
