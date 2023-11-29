{ pkgs, inputs, ... }:

let
  customLib = import ./../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/hyprland";

in
{

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };



  home-manager.users."klaasjan" = {

    # generate the script to stow hyprland's configuration files
    home.file."stow_dotfiles/stow_hyprland.sh" = {
      text = stow_script;
      executable = true;
    };

    xdg.configFile."hyprland.conf" = {
      enable = true;
      text =  ''
        source = ~/.config/hypr/hyprland_not_nixified.conf
        '';
      target = "hypr/hyprland.conf";
    };

  };

}
