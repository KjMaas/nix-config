{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gnupg       # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
    ssh-to-pgp  # Convert ssh private keys to PGP
    ssh-to-age  # Convert ssh private keys in ed25519 format to age keys
    sops        # Mozilla sops (Secrets OPerationS) is an editor of encrypted files
  ];

}
