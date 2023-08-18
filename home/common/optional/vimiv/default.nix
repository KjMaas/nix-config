{ pkgs, ... }:

{

  home.packages = with pkgs; [
    vimiv-qt  # Image viewer with Vim-like keybindings (Qt port)
  ];

  # ToDo: nixify vimiv configuration
  xdg.configFile."vimiv/vimiv.conf".source = ./vimiv.conf;
  xdg.configFile."vimiv/keys.conf".source = ./keys.conf;
  xdg.configFile."vimiv/styles/custom".source = ./styles/custom;
  
  xdg.desktopEntries.vimiv = {
    name = "Vimiv";
    genericName = "Vim Image Viewer";
    comment = "View images, the Vim way";
    exec = "vimiv %F";
    icon = "vimiv";
    mimeType = [
      "image/png"
      "image/jpg"
      "image/jpeg"
    ];
    terminal = false;
    type = "Application";
    categories = [ "Utility" "Viewer" ];
  };

  xdg.mimeApps.defaultApplications = {
    "image/png" = ["vimiv.desktop"];
    "image/jpg" = ["vimiv.desktop"];
    "image/jpeg" = ["vimiv.desktop"];
  };
}

