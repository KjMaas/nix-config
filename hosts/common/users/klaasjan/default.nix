{ pkgs, config, ... }:

{
  sops.secrets.klaasjan-password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;

  users.users.klaasjan = {
    home = "/home/klaasjan";
    # initialPassword = "admin";
    hashedPasswordFile = config.sops.secrets.klaasjan-password.path; # copy output of $ mkpasswd -m yescryp
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel" # sudo
      "network" # members of this group are able to set up networks through wpa_cli or wpa_gui
      "video" # needed for display modification, including brightness control
      "libvirtd" # used for libvirt/KVM virtualization
      "networkmanager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCX/dhNBpbd0lUJImxbZN4K9S7hrCKc3aequt9Se/cBnAecA+x2W+UAf7U6NuE0VHD/XJTfqe88hJfWdkswirzkwvpQ/p2Ru3l4Rru9YalDf1ZIpNKsnojidn/ex1kNGo3vqYJi732Ngl0HmveGeA2RzJkyLNm5rEAJt0MyM2mjHpKbRITeM8MwJu7OtwGxnGCVYLKNIeXfWNpz1oI1UAodw9WpRaxmwza/Sjht4POM+CAlSCjYIAf5Ob2rRBtgcy9GXWy6Yhm6ySf7aHQaIZ0AAqizYUeVYDeQZCyoLCbncPpBkobw3Mr6a9bTWW8p392GHzFu+Su/6uMyJwybM+sjyotppigLIMrKmELbT5noUtW0gog6rSxRkaPOHV9HezewvHQnQ/CD+T5VSVCd3G6YHqoTVipLohn3teq4hhOcz8fsw3aLlzi3esGR2muwursGW7BhRkPKjnX0K557UkpWFW74CChA1rp3duPjteayERyL9LQfNDh+kRv4OozVLZc= klaasjan@nixos"
    ];
  };

  programs.zsh.enable = true;

}
