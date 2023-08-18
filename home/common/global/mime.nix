{ pkgs, ... }:

{

  home.packages = with pkgs; [ 
    mimeo # Open files by MIME-type or file name using regular expressions
  ];

  # usefull commands:
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query filetype foo.pdf
  # XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default application/pdf
  # cat /home/klaasjan/.nix-profile/share/applications/mimeinfo.cache
  xdg.mimeApps.enable = true;
  xdg.mime.enable = true;

}


