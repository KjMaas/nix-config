{
  description = "Machine Configurations";

  nixConfig = {
    extra-substituters = [
      # hyprland
      "https://hyprland.cachix.org"
      # devenv
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      # hyprland
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # devenv
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-facter-modules.url = "github:numtide/nixos-facter-modules";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv/main";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin.url = "github:edolstra/nix-warez?dir=blender";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      determinate,
      disko,
      nixos-facter-modules,
      nixos-hardware,
      home-manager,
      sops-nix,
      devenv,
      blender-bin,
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
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./shell.nix { inherit pkgs; }
      );

      nixosConfigurations = {
        # Main Laptop
        razer = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/razer
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                blender-bin.overlays.default
                devenv.overlays.default
              ];
              home-manager = {
                useGlobalPkgs = true; # makes hm use nixos's pkgs value
                extraSpecialArgs = {
                  inherit inputs;
                }; # allows access to flake inputs in hm modules
                users = {
                  klaasjan.imports = [
                    ./home/klaasjan/razer.nix
                  ];
                };
              };
            }
          ];
        };

        serverIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            disko.nixosModules.disko
            ./hosts/common/global
            ./hosts/common/optional/iso.nix
            ./hosts/common/optional/kde.nix
            ./hosts/common/optional/wayland.nix
            ./hosts/common/users/root
          ];
        };

        atlax = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/atlax

            nixos-facter-modules.nixosModules.facter
            {
              config.facter.reportPath =
                if builtins.pathExists ./facter.json then
                  ./facter.json
                else
                  throw "Have you forgotten to run nixos-anywhere with `--generate-hardware-config nixos-facter ./facter.json`?";
            }
            disko.nixosModules.disko
            # nixos-hardware.nixosModules.framework-desktop-amd-ai-max-300-series
            determinate.nixosModules.default
            # {
            #   system.activationScripts = {
            #     mybootstrap.text = ''
            #       if [[ ! -e /bootstrap ]]; then
            #         cp -r ${./.} /bootstrap
            #       fi
            #     '';
            #     # Make install.sh executable and available at boot
            #     install.text = ''
            #       #!/bin/bash
            #       sudo nix --experimental-features "nix-command flakes" run \
            #         github:nix-community/disko/latest -- \
            #         --mode destroy,format,mount \
            #         /tmp/disk-config.nix
            #     '';
            #   };
            # }
          ];
        };
      };

      # nixopsConfigurations = {
      #   default = {
      #     inherit nixpkgs;
      #     network = {
      #       description = "Virtual testing environement";
      #       storage.legacy = { databasefile = "~/.nixops/razervm.nixops"; };
      #     };

      #     razervm = { ... }: {

      #       imports = [ ./hosts/razervm ];

      #       deployment.targetEnv = "virtualbox";
      #       deployment.virtualbox.memorySize = 4096;
      #       deployment.virtualbox.vcpu = 8;

      #       deployment.provisionSSHKey = true;
      #       deployment.targetUser = "root";
      #       deployment.targetHost = "razervm";
      #       deployment.targetPort = 22;

      #     };

      #   };
      # };

    };
}
