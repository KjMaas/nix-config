{
  description = "Machine Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs: 

  let
    inherit (self) outputs;

    hosts = rec {
      razervm = {
        system = "x86_64-linux";
        users = {
          "klaasjan" = {};
        };
      };
    };

    getUserModules =  modules: hostname: username: builtins.getAttr username modules.${hostname};

  in
  {

    # NixOS configuration modules for all the host machines
    nixosModules =
      builtins.mapAttrs
      (hostname: attrs: {inputs, ...}: {
        imports = [
          ./hosts/${hostname}
        ];
      })
      hosts;

    # home-manager configuration modules for every user on each host
    homeModules =
      builtins.mapAttrs
        (hostname: _: 
          (builtins.mapAttrs
            (user: _: {
                imports = [
                  home-manager.nixosModules.home-manager
                  {
                    home-manager = {
                      useGlobalPkgs = true;
                      useUserPackages = true;
                      users.${user} = {
                        imports = [ ./home/${user}/${hostname}.nix ];
                      };
                    };
                  }
                ];
            })
            hosts.${hostname}.users
        ))
        hosts;

    nixopsConfigurations = {
      default = {
        inherit nixpkgs;
        network = {
          description = "Nixos local testing environement";
          storage.legacy = {
            databasefile = "~/.nixops/razervm.nixops";
          };
        };

        razervm = { config, pkgs, ... }: {

          imports =  [
            self.nixosModules.razervm
            (getUserModules self.homeModules "razervm" "klaasjan")
          ];

          deployment.targetEnv = "virtualbox";
          deployment.virtualbox.memorySize = 4096;
          deployment.virtualbox.vcpu = 8;

          deployment.provisionSSHKey = true;
          deployment.targetUser = "root";
          deployment.targetHost = "razervm";
          deployment.targetPort = 22;

        };

      };
    };

  };
}
