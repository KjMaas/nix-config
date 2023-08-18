# https://nixos.wiki/wiki/Nvidia

{ pkgs, lib, config, ... }:

{
  imports = [
    ./prime.nix

    # ToFix: unable to launch Hyprland when sourcing disable.nix
    # ./disable.nix

  ];

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = lib.mkDefault true;
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;
  };

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = lib.mkDefault [ "nvidia" ];
  hardware.opengl.extraPackages = with pkgs; [
    vaapiVdpau  # VDPAU driver for the VAAPI library: https://nixos.wiki/wiki/Accelerated_Video_Playback
  ];

  hardware.nvidia = {

    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    # Only available on driver 515.43.04+
    open = true;

    # Enable the nvidia settings menu
    nvidiaSettings = true;

  };

  boot = {
    extraModulePackages = [ 
      config.boot.kernelPackages.nvidia_x11
    ];
  };

  environment.systemPackages = with pkgs; [
    linuxPackages.nvidia_x11

    nvtop   # A (h)top like task monitor for AMD, Intel and NVIDIA GPUs
  ];

  # environement.sessionVariables = {
  #   NIXOS_OZONE_WL = "1";
  #   MOZ_ENABLE_WAYLAND = "1";
  #   SDL_VIDEODRIVER = "wayland";
  #   _JAVA_AWT_WM_NONREPARENTING = "1";
  #   WLR_NO_HARDWARE_CURSORS = "1"; # fixes "no-cursor" problem
  #   GBM_BACKEND = "nvidia-drm";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   WLR_RENDERER = "vulkan";
  #   __NV_PRIME_RENDER_OFFLOAD="1";
  # };

}
