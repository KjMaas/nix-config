{ pkgs, inputs, ... }:

{
  services = {
    xserver.enable = true;

    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma6.enable = true;

    vault = {
      enable = true;
      package = pkgs.vault-bin;

      extraConfig = ''
        ui = true
      '';
    };
  };
}
