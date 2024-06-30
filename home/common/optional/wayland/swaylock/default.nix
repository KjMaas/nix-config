{ config, pkgs, ... }:

let
  inherit (config.colorscheme) palette;

in
{

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshots = true;
      clock = true;
      datestr = "%d/%m/%Y";
      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      effect-greyscale = true;
      fade-in = 0.5;
      grace = 2;

      # ToDo: use variable to set font to increase modularity
      font = "Fira Sans";
      font-size = 35;

      line-uses-inside = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-radius = 100;
      indicator-thickness = 7;
      indicator-idle-visible = true;
      # indicator-y-position = 100;

      line-color = "#${palette.base08}";
      ring-color = "#${palette.base02}";
      inside-wrong-color = "#${palette.base08}";
      ring-wrong-color = "#${palette.base08}";
      key-hl-color = "#${palette.base0B}";
      bs-hl-color = "#${palette.base08}";
      ring-ver-color = "#${palette.base09}";
      inside-ver-color = "#${palette.base09}";
      inside-color = "#${palette.base01}";
      text-color = "#${palette.base07}";
      text-clear-color = "#${palette.base01}";
      text-ver-color = "#${palette.base01}";
      text-wrong-color = "#${palette.base01}";
      text-caps-lock-color = "#${palette.base07}";
      inside-clear-color = "#${palette.base0C}";
      ring-clear-color = "#${palette.base0C}";
      inside-caps-lock-color = "#${palette.base09}";
      ring-caps-lock-color = "#${palette.base02}";
      separator-color = "#${palette.base02}";
    };

  };

}

