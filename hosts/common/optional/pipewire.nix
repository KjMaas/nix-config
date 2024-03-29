# for documentation on the Pipewire API, check https://docs.pipewire.org/

{ pkgs, ... }:

{

  # Remove sound.enable or turn it off if you had it set previously,
  # it seems to cause conflicts with pipewire?
  sound.enable = false;

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;

    wireplumber.enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
    jack.enable = false;
  };

  environment.systemPackages = with pkgs; [
    helvum  # A GTK patchbay for pipewire
  ];

}
