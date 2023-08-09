{ pkgs, config, ... }:

let
  notify = "${pkgs.libnotify}/bin/notify-send";
  swaylock = "${config.programs.swaylock.package}/bin/swaylock";
  pgrep = "${pkgs.procps}/bin/pgrep";
  hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";

  isLocked = "${pgrep} -x ${swaylock}";
  lockTime = 5 * 60;

  # Makes two timeouts: one for when the screen is not locked (lockTime+timeout) and one for when it is.
  afterLockTimeout = { timeout, command, resumeCommand ? null }: [
    { timeout = lockTime + timeout; inherit command resumeCommand; }
    { command = "${isLocked} && ${command}"; inherit resumeCommand timeout; }
  ];
in
{
  services.swayidle = {
    enable = true;
    systemdTarget = "graphical-session.target";

    events = [
      {
        event = "before-sleep";
        command = "${notify} -t 5000 -u normal 'before-resume'";
      }
      {
        event = "after-resume";
        command = "${notify} -t 5000 -u normal 'after-resume'";
      }
      {
        event = "lock";
        command = "${notify} -t 5000 -u normal 'lock' && ${swaylock} --daemonize";
      }
      {
        event = "unlock";
        command = "${notify} -t 5000 -u normal 'unlock'";
      }
    ];

    timeouts =

      # Lock screen
      [{
        timeout = lockTime;
        command = "${swaylock} --daemonize";
      }] ++

      # Turn off displays (on Hyprland)
      (afterLockTimeout {
        timeout = 60;
        command = "${hyprctl} dispatch dpms off";
        resumeCommand = "${hyprctl} dispatch dpms on";
      });

  };
}
