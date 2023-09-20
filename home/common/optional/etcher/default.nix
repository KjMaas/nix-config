{ pkgs, ... }:

{

  home.packages = [
    pkgs.etcher  # Flash OS images to SD cards and USB drives, safely and easily
  ];
  
  # Configure which file types are opened with NeoVim by default
  xdg.desktopEntries.etcher = {
    name = "Etcher";
    genericName = "BalenaEtcher";
    comment = "Flash OS images to SD cards and USB drives, safely and easily";
    exec = "etcher --disable-gpu-sandbox";
    icon = "etcher";
    terminal = false;
    type = "Application";
    categories = [ "Utility" ];
  };

}
