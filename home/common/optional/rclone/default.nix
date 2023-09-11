{ pkgs, inputs, ... }:

let
  # ToDo: increase modularity (don't pin the user name)
  user = "klaasjan";
  mountdir = "/home/${user}/onedrive/";

in
{
  imports = [
      inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    gnupg.home = "/home/${user}/.gnupg";
    defaultSopsFile = ./drives.yaml;
    secrets."drive-01" = {
      path = "/home/${user}/.config/rclone/rclone.conf"; 
    };
  };

  home.packages = with pkgs; [
    rclone          # Command line program to sync files and directories to and from major cloud storage
    rclone-browser  # Graphical Frontend to Rclone written in Qt
  ];

  systemd.user.services.onedrive_mount = {
    Unit = {
      Description = "Mount OneDrive";
      After = [ "network-online.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${mountdir}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount OneDrive: ${mountdir} \
        --dir-cache-time 48h \
        --vfs-cache-mode full \
        --vfs-cache-max-age 48h \
        --vfs-read-chunk-size 10M \
        --vfs-read-chunk-size-limit 512M \
        --buffer-size 512M
        '';
      ExecStartPost = ''
        ${pkgs.rclone}/bin/rclone copyto OneDrive:Documents/Safe.kdbx /home/${user}/Safe_backup.kdbx
        '';
      ExecStop = "/run/wrappers/bin/fusermount -u ${mountdir}";
      Type = "notify";
      Restart = "always";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
  };

}

