{
  description = "Machine Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }@inputs: 

  let
    inherit (self) outputs;

  in
  {

    nixopsConfigurations = {
      default = {
        inherit nixpkgs;
        network.storage.legacy = {
          databasefile = "~/.nixops/razervm.nixops";
        };

        network.description = "My NixOS Deployment";
        razervm = { config, pkgs, ... }: {
          imports = [
            ./hosts/razervm
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
