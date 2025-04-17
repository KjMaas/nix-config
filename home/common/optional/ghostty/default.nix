{ config, ... }:

let
  inherit (config.colorscheme) palette;

in
{
  programs.ghostty.enable = true;
}
