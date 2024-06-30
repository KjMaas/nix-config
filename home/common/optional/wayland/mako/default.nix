{ pkgs, config, ... }:

let
  inherit (config.colorscheme) palette;

in
{
  home.packages = [
  	pkgs.libnotify	# A library that sends desktop notifications to a notification daemon
  ];

  services.mako = {
    enable = true;
    actions = true;
    anchor = "bottom-right";
    layer = "top";

    backgroundColor = "#${palette.base01}";
    borderColor = "#${palette.base0D}";
    progressColor = "over #${palette.base09}";
    textColor = "#${palette.base0C}";
    borderRadius = 5;
    borderSize = 3;
    defaultTimeout = 10;
    font = "DejaVu Sans Mono 10";
    width = 300;
    height = 100;
    margin = "10";
    padding = "10";
    icons = true;
    iconPath = "foo/bar";
    maxIconSize = 64;
    sort = "+time";
    maxVisible = 5;

    extraConfig = ''
      history=1
      max-history=20
      icon-location=right
      text-alignment=center

      [urgency=low]
      background-color=#${palette.base03}
      text-color=#${palette.base0B}
      border-color=#${palette.base0A}

      [urgency=high]
      background-color=#${palette.base0A}
      text-color=#${palette.base09}
      border-color=#${palette.base08}
    '';
  };

}
