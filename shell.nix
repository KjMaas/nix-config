# Shell for bootstrapping flake-enabled nix and home-manager
# $ nix develop

{ pkgs ? (import ./nixpkgs.nix) { } }:

{
  default = pkgs.mkShell {
    # Enable experimental features without having to specify the argument
    NIX_CONFIG = "experimental-features = nix-command flakes";

    nativeBuildInputs = with pkgs; [
      # minimal Nix environment
      nix           # Powerful package manager that makes package management reliable and reproducible
      git           # Distributed version control system
      home-manager  # A Nix-based user environment configurator

      # sops bootstraping and secrets edition
      gnupg       # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
      ssh-to-pgp  # Convert ssh private keys to PGP
      ssh-to-age  # Convert ssh private keys in ed25519 format to age keys
      sops        # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
    ];
  };

}
