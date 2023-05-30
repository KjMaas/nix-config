{ pkgs, config, ... }: {

  users.users.klaasjan = {
    isNormalUser = true;
    initialPassword = "admin";
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
    ];
  };

  environment.variables = {
    EDITOR = "nvim";
  };

}
