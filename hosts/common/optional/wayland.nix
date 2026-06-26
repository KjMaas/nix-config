{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Forward graphics through ssh
    waypipe # A network proxy for Wayland clients (applications)
  ];

}
