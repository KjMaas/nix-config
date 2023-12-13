{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager  # Desktop user interface for managing virtual machines
    virt-top      # A top-like utility for showing stats of virtualized domains
    opentofu      # Tool for building, changing, and versioning infrastructure
  ];


  home-manager.users.klaasjan.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

}

