{
  description = "Machine Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }@inputs: 

  let
    inherit (self) outputs;
    lib = nixpkgs.lib;

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

    nixosConfigurations = {
      # Main Laptop
      razer =  lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [ 
          ./hosts/razer
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;                   # makes hm use nixos's pkgs value
              extraSpecialArgs = { inherit inputs; }; # allows access to flake inputs in hm modules
              users = {
                klaasjan.imports = [ ./home/klaasjan/razer.nix ];
              };
            };
          }
        ];
      };
    };


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
