{

  # Remove sound.enable or turn it off if you had it set previously,
  # it seems to cause conflicts with pipewire?
  sound.enable = true;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = false;
  };

}
