{ config, ... }:

let
  inherit (config.colorscheme) colors;

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

      default-bg = "#${colors.base00}";
      default-fg = "#${colors.base01}";
      statusbar-bg = "#${colors.base02}";
      statusbar-fg = "#${colors.base04}";
      inputbar-bg = "#${colors.base00}";
      inputbar-fg = "#${colors.base07}";
      notification-bg = "#${colors.base00}";
      notification-fg = "#${colors.base07}";
      notification-error-bg = "#${colors.base00}";
      notification-error-fg = "#${colors.base08}";
      notification-warning-bg = "#${colors.base00}";
      notification-warning-fg = "#${colors.base08}";
      highlight-color = "#${colors.base0A}";
      highlight-active-color = "#${colors.base0D}";
      completion-bg = "#${colors.base01}";
      completion-fg = "#${colors.base05}";
      completions-highlight-bg = "#${colors.base0D}";
      completions-highlight-fg = "#${colors.base07}";
      recolor-lightcolor = "#${colors.base00}";
      recolor-darkcolor = "#${colors.base06}";
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
