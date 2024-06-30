{ config, ... }:

let
  inherit (config.colorscheme) palette;

in
{

  programs.zathura = {
    enable = true;

    mappings = {
      "<Right>" = "navigate next";
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      r = "reload";
      R = "rotate";
      K = "zoom in";
      J = "zoom out";
      i = "recolor";
      p = "print";
    };

    options = {
      sandbox = "none";
      statusbar-h-padding = 0;
      statusbar-v-padding = 0;
      page-padding = 1;
      selection-clipboard = "clipboard";
      recolor = true; # ie "Dark mode" by default

      default-bg = "#${palette.base00}";
      default-fg = "#${palette.base01}";
      statusbar-bg = "#${palette.base02}";
      statusbar-fg = "#${palette.base04}";
      inputbar-bg = "#${palette.base00}";
      inputbar-fg = "#${palette.base07}";
      notification-bg = "#${palette.base00}";
      notification-fg = "#${palette.base07}";
      notification-error-bg = "#${palette.base00}";
      notification-error-fg = "#${palette.base08}";
      notification-warning-bg = "#${palette.base00}";
      notification-warning-fg = "#${palette.base08}";
      highlight-color = "#${palette.base0A}";
      highlight-active-color = "#${palette.base0D}";
      completion-bg = "#${palette.base01}";
      completion-fg = "#${palette.base05}";
      completions-highlight-bg = "#${palette.base0D}";
      completions-highlight-fg = "#${palette.base07}";
      recolor-lightcolor = "#${palette.base00}";
      recolor-darkcolor = "#${palette.base06}";
    };

  };


  # Configure which file types are opened with Zathura by default
  # ToDo: use already existing zathura.desktop file:
  # https://wiki.archlinux.org/title/Zathura#Make_zathura_the_default_pdf_viewer
  xdg.desktopEntries.zathura = {
    name = "Zathura";
    genericName = "PDF viewer";
    comment = "A highly customizable and functional PDF viewer";
    exec = "zathura %F";
    icon = "zathura";
    mimeType = [
      "application/pdf"
    ];
    terminal = false;
    type = "Application";
    categories = [ "Utility" ];
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "zathura.desktop" ];
  };

}
