{ pkgs, ... }:

let 
  nixops_unstable_override = pkgs.nixops_unstable.override {
    overrides = (self: super: {
      nixopsvbox = super.nixopsvbox.overridePythonAttrs (
        _: {
          src = pkgs.fetchgit {
            url = "https://github.com/KjMaas/nixops-vbox.git";
            rev = "6db55874a3d426c07b4dc957a08678417efa0ca6";
            sha256 = "sha256-ssNYLdkehhuBBZ+GuDq8wFq87zGnog+56wJP/Q/6ruc=";
          };
        }
      );
      nixops-virtd = super.nixops-virtd.overridePythonAttrs (
        _: {
          src = pkgs.fetchgit {
            url = "https://github.com/deepfire/nixops-libvirtd";
            rev = "71964407008f8ce0549138544bda4c91298d7e44";
            sha256 = "sha256-HxJu8/hOPI5aCddTpna0mf+emESYN3ZxpTkitfKcfVQ=";
          };
        }
      );
    });
  };

in

{

  environment.systemPackages = [
    nixops_unstable_override  # NixOS cloud provisioning and deployment tool
  ];

}
