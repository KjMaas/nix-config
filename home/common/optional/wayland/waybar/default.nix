{ inputs, config, pkgs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
  };

  # Dependencies
  jq = "${pkgs.jq}/bin/jq";
  systemctl = "${pkgs.systemd}/bin/systemctl";
  journalctl = "${pkgs.systemd}/bin/journalctl";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  playerctld = "${pkgs.playerctl}/bin/playerctld";
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
  btop = "${pkgs.btop}/bin/btop";
  nvtop = "${pkgs.nvtop}/bin/nvtop";
  # nvidia-smi = "${pkgs.linuxPackages.nvidia_x11}/bin/nvidia-smi"; # ToFix

  terminal = "${pkgs.kitty}/bin/kitty";
  terminal-spawn = cmd: "${terminal} $SHELL -i -c ${cmd}";

  systemMonitor = terminal-spawn btop;
  gpuMonitor = terminal-spawn nvtop;

  # Function to simplify making waybar outputs
  jsonOutput = name: { pre ? "", text ? "", tooltip ? "", alt ? "", class ? "", percentage ? "" }: "${pkgs.writeShellScriptBin "waybar-${name}" ''
    set -euo pipefail
    ${pre}
    ${jq} -cn \
      --arg text "${text}" \
      --arg tooltip "${tooltip}" \
      --arg alt "${alt}" \
      --arg class "${class}" \
      --arg percentage "${percentage}" \
      '{text:$text,tooltip:$tooltip,alt:$alt,class:$class,percentage:$percentage}'
  ''}/bin/waybar-${name}";

in
{
  imports = [
    ../../btop
    ../gammastep
  ];

  home.packages = [
      pkgs.jq
      pkgs.playerctl
      pkgs.pavucontrol
  ];


  programs.waybar = {
    enable = true;
    # [22/08/2023]ToCheck: switch to stable nixpkgs once hyprland/window module is merged
    package = unstable.waybar;

    settings = {

      secondary = {
        # mode = "dock"; # -> generates a bug where waybar is rendered below the windows
        layer = "top";
        height = 32;
        margin = "6";
        position = "bottom";
        modules-left = [
          "hyprland/window"
        ];
        modules-center = [
          "hyprland/workspaces"
        ];
        modules-right = [
          "idle_inhibitor"
        ];

        "hyprland/window" = {
          max-length = 200;
          separate-outputs = false;
        };

        "hyprland/workspaces" = {
          sort-by-number = true;
          on-click = "activate";
          disable-scroll = false;
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format = "{icon} {name} {icon}";
          format-icons = {
            urgent = "";
            focused = "";
            default = "";
          };
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };

      };

      primary = {
        # mode = "dock";
        layer = "top";
        height = 40;
        margin = "6";
        position = "top";
        modules-left = [
          "custom/menu"
          "custom/currentplayer"
          "custom/player"
        ];
        modules-center = [
          "disk"
          "cpu"
          "custom/igpu"
          "custom/dgpu"
          "memory"
          "clock"
          "backlight"
          "temperature"
          "pulseaudio"
          "custom/gammastep"
        ];
        modules-right = [
          "custom/gamemode"
          "network"
          "custom/tailscale-ping"
          "battery"
          "tray"
          "custom/hostname"
        ];

        disk = {
            interval = 30;
            format = "󰋊  {percentage_free}%";
            path = "/";
        };

        clock = {
          format = "{:%d/%m %H:%M}";
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
        };

        cpu = {
          format = "󰍛   {usage}%";
          on-click = systemMonitor;
        };

        "custom/igpu" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput "igpu" {
            text = "$(cat /sys/class/drm/card0/device/gpu_busy_percent)";
            tooltip = ''
              Integrated GPU Usage
              -------------------------------
            '';
          };
          format = "i󰒋  {}%";
          on-click = gpuMonitor;
        };

        "custom/dgpu" = {
          interval = 2;
          return-type = "json";
          # exec = "nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits";
          exec = jsonOutput "dgpu" {
            text = "$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)";
            tooltip = ''
             Dedicated GPU Usage
             -------------------------------
             $(nvidia-smi -q | grep 'Product Name' | sed -E "s/[[:space:]]+/ /g")
             $(nvidia-smi -q | grep 'Driver Version' | sed -E "s/[[:space:]]+/ /g")
             $(nvidia-smi -q | grep 'CUDA Version' | sed -E "s/[[:space:]]+/ /g")

             GPU : $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader)
             Memory : $(nvidia-smi --query-gpu=utilization.memory --format=csv,noheader)

             Temp GPU : $(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader) ºC
             Temp Mem. : $(nvidia-smi --query-gpu=temperature.memory --format=csv,noheader) ºC

             Power Draw : $(nvidia-smi --query-gpu=power.draw --format=csv,noheader)
           '';
          };
          format = "d󰒋  {}%";
          on-click = gpuMonitor;
        };

        memory = {
          format = "  {}%";
          interval = 5;
          on-click = systemMonitor;
        };

        pulseaudio = {
          format = "{icon}  {volume}%";
          format-muted = "   0%";
          format-icons = {
            headphone = "󰋋";
            headset = "󰋎";
            portable = "";
            default = [ "" "" "" ];
          };
          on-click = pavucontrol;
        };

        battery = {
          bat = "BAT0";
          interval = 10;
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          onclick = "";
        };

        temperature = {
          critical-threshold = 70;
          format-critical = "{temperatureC}°C ⚠️ ";
          format = "{temperatureC}°C {icon}";
          format-icons = ["" "" ""];
        };

        backlight = {
          format = "{percent}% {icon}";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          on-scroll-up = "light -T 1.1";
          on-scroll-down = "light -T 0.9";
        };

        network = {
          interval = 3;
          format-wifi = "   {essid}";
          format-ethernet = "󰈁 Connected";
          format-disconnected = "󰈂 Disconnected";
          tooltip-format = ''
            {ifname}
            {ipaddr}/{cidr}
            Up: {bandwidthUpBits}
            Down: {bandwidthDownBits}'';
          on-click = "";
        };

        "custom/menu" = {
          return-type = "json";
          exec = jsonOutput "menu" {
            text = "";
            tooltip = ''$(cat /etc/os-release | grep PRETTY_NAME | cut -d '"' -f2)'';
          };
        };

        "custom/hostname" = {
          exec = "echo $USER@$(hostname)";
          on-click = terminal;
        };

        # ToFix: gammastep widget doesn't show up
        "custom/gammastep" = {
          interval = 5;
          return-type = "json";
          exec = jsonOutput "gammastep" {
            pre = ''
              if unit_status="$(${systemctl} --user is-active gammastep)"; then
                status="$unit_status ($(${journalctl} --user -u gammastep.service -g 'Period: ' | tail -1 | cut -d ':' -f6 | xargs))"
              else
                status="$unit_status"
              fi
            '';
            alt = "\${status:-inactive}";
            tooltip = "Gammastep is $status";
          };
          format = "{icon}";
          format-icons = {
            "activating" = "󰁪 ";
            "deactivating" = "󰁪 ";
            "inactive" = "? ";
            "active (Night)" = " ";
            "active (Nighttime)" = " ";
            "active (Transition (Night)" = " ";
            "active (Transition (Nighttime)" = " ";
            "active (Day)" = " ";
            "active (Daytime)" = " ";
            "active (Transition (Day)" = " ";
            "active (Transition (Daytime)" = " ";
          };
          on-click = "${systemctl} --user is-active gammastep && ${systemctl} --user stop gammastep || ${systemctl} --user start gammastep";
        };
        
        "custom/currentplayer" = {
          interval = 2;
          return-type = "json";
          exec = jsonOutput "currentplayer" {
            pre = ''
              player="$(${playerctl} status -f "{{playerName}}" 2>/dev/null || echo "No player active" | cut -d '.' -f1)"
              count="$(${playerctl} -l | wc -l)"
              if ((count > 1)); then
                more=" +$((count - 1))"
              else
                more=""
              fi
            '';
            alt = "$player";
            tooltip = "$player ($count available)";
            text = "$more";
          };
          format = "{icon}{}";
          format-icons = {
            "No player active" = " ";
            "Celluloid" = "󰎁 ";
            "spotify" = " 󰓇";
            "ncspot" = " 󰓇";
            "qutebrowser" = "󰖟";
            "firefox" = " ";
            "discord" = " 󰙯 ";
            "sublimemusic" = " ";
            "kdeconnect" = "󰄡 ";
          };
          on-click = "${playerctld} shift";
          on-click-right = "${playerctld} unshift";
        };

        "custom/player" = {
          exec-if = "${playerctl} status";
          exec = ''${playerctl} metadata --format '{"text": "{{artist}} - {{title}}", "alt": "{{status}}", "tooltip": "{{title}} ({{artist}} - {{album}})"}' '';
          return-type = "json";
          interval = 2;
          max-length = 30;
          format = "{icon} {}";
          format-icons = {
            "Playing" = "󰐊";
            "Paused" = "󰏤 ";
            "Stopped" = "󰓛";
          };
          on-click = "${playerctl} play-pause";
        };
      };

    };

    # ToDo: use variable to set font to increase modularity
    style = let inherit (config.colorscheme) colors; in ''

      * {
        font-family: "Fira Sans";
        font-size: 12pt;
        padding: 0 8px;
      }

      .modules-right {
        margin-right: -15px;
      }

      .modules-left {
        margin-left: -15px;
      }

      window#waybar.top {
        opacity: 0.95;
        padding: 0;
        background-color: #${colors.base00};
        border: 2px solid #${colors.base0C};
        border-radius: 10px;
      }
      
      window#waybar.bottom {
        opacity: 0.90;
        background-color: #${colors.base00};
        border: 2px solid #${colors.base0C};
        border-radius: 10px;
      }

      window#waybar {
        color: #${colors.base05};
        background: #${colors.base08};
        padding: 20px;
      }

      #workspaces button {
        background-color: #${colors.base01};
        color: #${colors.base05};
        margin: 4px;
      }

      #workspaces button.hidden {
        background-color: #${colors.base00};
        color: #${colors.base04};
      }

      #workspaces button.focused,
      #workspaces button.active {
        background-color: #${colors.base0A};
        color: #${colors.base00};
      }

      #clock {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 15px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }

      #custom-menu {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 22px;
        margin-left: 0;
        margin-right: 10px;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }

      #custom-hostname {
        background-color: #${colors.base0C};
        color: #${colors.base00};
        padding-left: 15px;
        padding-right: 18px;
        margin-right: 0;
        margin-top: 0;
        margin-bottom: 0;
        border-radius: 10px;
      }

      #tray {
        color: #${colors.base05};
      }
    '';
  };
}
