# https://github.com/NixOS/nixos-hardware/blob/429f232fe1dc398c5afea19a51aad6931ee0fb89/common/gpu/nvidia/prime.nix

{ lib, pkgs, ... }:

# This creates a new 'nvidia-offload' program that runs the application passed to it on the GPU
# As per https://nixos.wiki/wiki/Nvidia
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';

in {

  environment.systemPackages = [ nvidia-offload ];

  hardware.nvidia.prime = {

      offload ={
        enable = lib.mkOverride 990 true;
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
}
