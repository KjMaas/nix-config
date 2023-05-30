# These configs are common to all the hosts

{ inputs, outputs, ... }: {
  imports = [
    ./locale.nix
    ./nix.nix
    ./openssh.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

  # backlight
  programs.light.enable = true;

}
