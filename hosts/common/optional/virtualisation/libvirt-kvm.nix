{ pkgs, ... }:

{

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      swtpm.enable = true;
      # ovmf.enable = true;
    };
  };

  programs.virt-manager.enable = true; # Desktop user interface for managing virtual machines

  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [
    # virt-manager  # Desktop user interface for managing virtual machines
    virt-top # A top-like utility for showing stats of virtualized domains
    # opentofu      # Tool for building, changing, and versioning infrastructure
    # virtualisation
    # virt-manager
    virt-viewer
    qemu
    OVMF
  ];

  # libvirt configuration
  virtualisation.libvirtd.extraConfig = ''
    unix_sock_group = "libvirtd"
    unix_sock_rw_perms = "0770"
  '';

  # home-manager.users.klaasjan.dconf.settings = {
  #   "org/virt-manager/virt-manager/connections" = {
  #     autoconnect = [ "qemu:///system" ];
  #     uris = [ "qemu:///system" ];
  #   };
  # };

}
