{ pkgs, config, ... }:

let
  inherit (config.colorscheme) colors;

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

    backgroundColor = "#${colors.base01}";
    borderColor = "#${colors.base0D}";
    progressColor = "over #${colors.base09}";
    textColor = "#${colors.base0C}";
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
      background-color=#${colors.base03}
      text-color=#${colors.base0B}
      border-color=#${colors.base0A}

      [urgency=high]
      background-color=#${colors.base0A}
      text-color=#${colors.base09}
      border-color=#${colors.base08}
    '';
  };

}
