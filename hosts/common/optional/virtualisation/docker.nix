{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;

    rootless = {
      enable = false;
      setSocketVariable = true;
    };

  };


  environment.systemPackages = with pkgs; [
    docker-compose  
  ];


  # users.users.klaasjan.extraGroups = [ "docker" ];

}

