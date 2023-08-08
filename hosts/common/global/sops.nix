{ inputs, lib, config, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.sshKeyPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
    ];
  };

  # ----------------------------------------------------------
  # setup gpg key from ssh key (will be used to edit secrets): 
  # ----------------------------------------------------------
  # $ ssh-to-pgp -private-key -i $HOME/.ssh/id_rsa | gpg --import --quiet
  # This exports the public key
  # $ ssh-to-pgp -i $HOME/.ssh/id_rsa -o $USER.asc
  #
  # ---------------------------------
  # Find the GPG fingerprint of a key
  # ---------------------------------
  # gpg --list-secret-keys
  # out:  /home/<user>/.gnupg/pubring.kbx
  #       ---------------------------------
  #       sec   rsa3072 1970-01-01 [SCE]
  #             XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  #       uid           [ultimate] root (Imported from SSH) <root@localhost>
  #
  # ----------
  # add a host
  # ----------
  # $ cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age
  # out: age1e93966qycw329almzdcu3quweufwpf3j0mtp0k3g7nxfmvzpha0srahnv2

  # ToDo: store private key on a Yubikey:
  # https://rzetterberg.github.io/yubikey-gpg-nixos.html
}
