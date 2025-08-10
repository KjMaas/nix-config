{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };

  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/walker";

in
{
  home.packages = with pkgs; [

    # unstable.walker # Wayland-native application runner
    inputs.walker.packages."x86_64-linux".default # install latest version from flake

    # Extend walker with Calculator, bluetooth and wifi managers
    unstable.bzmenu # Launcher-driven Bluetooth manager for Linux
    unstable.iwmenu # Launcher-driven Wi-Fi manager for Linux
    libqalculate # Advanced calculator library - used for `walker --module calc`
  ];

  # generate the script to stow the configuration file(s)
  home.file."stow_dotfiles/stow_walker.sh" = {
    text = stow_script;
    executable = true;
  };
}
