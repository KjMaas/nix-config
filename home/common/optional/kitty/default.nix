{ config, ... }:

let
  inherit (config.colorscheme) palette;

in
{

  imports = [
    ../zsh
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "kitty_mod+\\" = "launch --cwd=current";
      "kitty_mod+enter" = "new_os_window_with_cwd";
      "kitty_mod+q" = "close_window";
      "kitty_mod+l" = "next_window";
      "kitty_mod+h" = "previous_window";
      "kitty_mod+c" = "copy_and_clear_or_interrupt";
      "kitty_mod+v" = "paste_from_clipboard";
    };
    font = {
      # ToDo: use variable to set font to increase modularity
      name = "FiraMono Nerd Font";
      size = 12;
    };
    settings = {
      scrollback_lines = 4242;
      scrollback_pager_history_size = 2048;
      window_padding_width = 10;
      enable_audio_bell = "no";
      visual_bell_duration = 0;
      confirm_os_window_close = 3;
      kitty_mod = "ctrl+shift";

      # color theme
      foreground = "#${palette.base05}";
      background = "#${palette.base00}";
      selection_background = "#${palette.base05}";
      selection_foreground = "#${palette.base00}";
      url_color = "#${palette.base04}";
      cursor = "#${palette.base05}";
      active_border_color = "#${palette.base03}";
      inactive_border_color = "#${palette.base01}";
      active_tab_background = "#${palette.base00}";
      active_tab_foreground = "#${palette.base05}";
      inactive_tab_background = "#${palette.base01}";
      inactive_tab_foreground = "#${palette.base04}";
      tab_bar_background = "#${palette.base01}";
      color0 = "#${palette.base00}";
      color1 = "#${palette.base08}";
      color2 = "#${palette.base0B}";
      color3 = "#${palette.base0A}";
      color4 = "#${palette.base0D}";
      color5 = "#${palette.base0E}";
      color6 = "#${palette.base0C}";
      color7 = "#${palette.base05}";
      color8 = "#${palette.base03}";
      color9 = "#${palette.base08}";
      color10 = "#${palette.base0B}";
      color11 = "#${palette.base0A}";
      color12 = "#${palette.base0D}";
      color13 = "#${palette.base0E}";
      color14 = "#${palette.base0C}";
      color15 = "#${palette.base07}";
      color16 = "#${palette.base09}";
      color17 = "#${palette.base0F}";
      color18 = "#${palette.base01}";
      color19 = "#${palette.base02}";
      color20 = "#${palette.base04}";
      color21 = "#${palette.base06}";
    };

  };

}
