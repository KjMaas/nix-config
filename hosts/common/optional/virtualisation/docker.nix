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
    # arion             # Run docker-compose with help from Nix/NixOS
    docker-compose  # Docker CLI plugin to define and run multi-container applications with Docker 
    # kubernetes      # Production-Grade Container Scheduling and Management
  ];


  users.users.klaasjan.extraGroups = [ "docker" ];

}

