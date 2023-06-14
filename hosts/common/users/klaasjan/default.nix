{ pkgs, config, ... }: {

  users.users.klaasjan = {
    isNormalUser = true;
    initialPassword = "admin";
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
