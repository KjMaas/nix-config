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
    ...
  }@inputs: 

  let
    inherit (self) outputs;

    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];

  in
  {

    # Devshell for bootstrapping
    devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
    );


    nixopsConfigurations = {
      default = {
        inherit nixpkgs;
        network = {
          description = "Virtual testing environement";
          storage.legacy = {
            databasefile = "~/.nixops/razervm.nixops";
          };
        };

        razervm = { ... }: {

          imports =  [
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
