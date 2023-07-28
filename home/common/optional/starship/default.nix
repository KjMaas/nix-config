{ config, ... }:

let
  inherit (config.colorscheme) colors;

  bright = "#${colors.base0A}";
  warning = "#${colors.base08}";
  warning2 = "#${colors.base09}";
  success = "#${colors.base0B}";
  base = "#${colors.base0C}";
  base2 = "#${colors.base0D}";
  subtle = "#${colors.base0E}";
  highlight = "#${colors.base07}";

in
{

  programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;

      settings = {

        # PR for transient prompt in zsh:
        # https://github.com/starship/starship/pull/4205
        format =
        let
          git = "$git_branch$git_commit$git_state$git_status";
        in
        ''
          ($username$hostname) ($cmd_duration) $fill ($time)
          ($shlvl) ($directory) (${git})($all)
          ($battery) $character
        '';

        right_format = ''
        '';

        fill = {
          symbol = " ";
          disabled = false;
        };

        line_break.disabled = true;

        battery = {
          disabled = false;
          format = "[$symbol$percentage]($style)";
          full_symbol = "󰁹 ";
          unknown_symbol = "󰁽 ";
          empty_symbol = "󰂎 ";
          charging_symbol = "󰂄 ";
          discharging_symbol = "󰂃 ";
          display = [
            { threshold = 10; style = "bold ${warning}"; }
            { threshold = 15; style = "${warning2}"; }
          ];
        };

        username = {
          disabled = false;
          format = "[$user]($style)";
          show_always = true;
          style_root = "bold ${warning2}";
          style_user = "bold ${base}";
        };
        
        hostname = {
          disabled = false;
          format = "[@]($style)[$hostname$ssh_symbol](bold ${base2})";
          ssh_symbol = "🌏 ";
          ssh_only = false;
          style = "bold ${highlight}";
        };

        shlvl = {
          disabled = false;
          format = "[|$shlvl|]($style)";
          style = "dimmed ${bright}";
          threshold = 2;
          repeat = true;
        };

        cmd_duration = {
          disabled = false;
          format = "[took ](${subtle})[$duration]($style)";
          style = "bold ${subtle}";
          min_time = 2000;
          show_milliseconds = false;
          show_notifications = true;
          min_time_to_notify = 10000;
        };

        time = {
          disabled = false;
          format = "[$time]($style)";
          style = "${subtle}";
          use_12hr = false;
          time_format = "%T";
          utc_time_offset = "local";
          time_range = "00:00:00-24:00:00";
        };

        directory = {
          disabled = false;
          format = "[$path]($style)( [$read_only]($read_only_style)) ";
          style = "${base}";
          before_repo_root_style = "${base}";
          repo_root_style = "bold ${base}";
          repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
          home_symbol = "~";
          use_os_path_sep = true;
          truncation_length = 5;
          truncate_to_repo = true;
          truncation_symbol = ".../";
          read_only = "🔒";
          read_only_style = "${warning}";
        };

        character = {
          disabled = false;
          error_symbol = "[~>](bold ${warning})";
          success_symbol = "[->](bold ${success})";
          vimcmd_symbol = "[](bold green)";
        };

      };

  };

}

