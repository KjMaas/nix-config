{ pkgs, config, ... }:

let
  inherit (config.colorscheme) palette;

in
{
  home.packages = [
    pkgs.libnotify # A library that sends desktop notifications to a notification daemon
  ];

  services.mako = {
    enable = true;
    settings = {
      actions = true;
      anchor = "bottom-right";
      layer = "top";

      background-color = "#${palette.base01}";
      border-color = "#${palette.base0D}";
      progress-color = "over #${palette.base09}";
      text-color = "#${palette.base0C}";
      border-radius = 5;
      border-size = 3;
      default-timeout = 10;
      font = "DejaVu Sans Mono 10";
      width = 300;
      height = 100;
      margin = "10";
      padding = "10";
      icons = true;
      icon-path = "foo/bar";
      max-icon-size = 64;

      sort = "+time";
      max-visible = 5;

    };

    # BUG: The option definition `services.mako.extraConfig' no longer has any effect; please remove it. ... but the Home Manager documentation still has the option.
    # Check again for the next update (ie: nixpkgs >= 25.05)

    # extraConfig = ''
    #     history=1
    #     max-history=20
    #     icon-location=right
    #     text-alignment=center

    #     [urgency=low]
    #     background-color=#${palette.base03}
    #     text-color=#${palette.base0B}
    #     border-color=#${palette.base0A}

    #     [urgency=high]
    #     background-color=#${palette.base0A}
    #     text-color=#${palette.base09}
    #     border-color=#${palette.base08}
    # '';

  };

}
