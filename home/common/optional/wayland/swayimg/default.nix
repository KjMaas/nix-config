{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };

  customLib = import ./../../../../../customLib.nix;
  stow_script = customLib.stow_dotfiles_script "common/optional/wayland/swayimg";

in
{
  home.packages = with pkgs; [
    unstable.swayimg # Image viewer for Sway/Wayland
  ];

  # generate the script to stow the configuration file(s)
  home.file."stow_dotfiles/stow_swayimg.sh" = {
    text = stow_script;
    executable = true;
  };

  xdg.desktopEntries.swayimg = {
    name = "Swayimg";
    genericName = "Wayland-native Image Viewer";
    comment = "";
    exec = "swayimg %F";
    icon = "swayimg";
    mimeType = [
      "image/webp"
      "image/svg"
    ];
    terminal = false;
    type = "Application";
    categories = [
      "Utility"
      "Viewer"
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "image/webp" = [ "vimiv.desktop" ];
    "image/svg" = [ "vimiv.desktop" ];
  };
}
