{ pkgs, ... }:

{

  # Free and open source software for video recording and live streaming
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
    ];
  };

}
