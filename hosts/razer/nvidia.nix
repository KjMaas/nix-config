# https://nixos.wiki/wiki/Nvidia

{ pkgs, config, ... }:

let

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

in
{
  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

    prime = {
      offload ={
        enable = true;
        enableOffloadCmd = true;
      };

      # to determine the BusIds:
      # nix-shell -p lshw --run "lshw -c display"
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:4:0:0";

      # In sync mode the Nvidia card is turned on constantly,
      # having impact on laptop battery and health 
      sync.enable = false;
    };

  };

  boot.extraModulePackages = [ 
    config.boot.kernelPackages.nvidia_x11
  ];

  environment.systemPackages = with pkgs; [
    # graphics
    nvidia-offload
    linuxPackages.nvidia_x11
  ];

}
