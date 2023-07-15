{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" "nvidia" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ 
    config.boot.kernelPackages.broadcom_sta
  ];

  fileSystems."/" =
    { device = "/dev/disk/by-label/nixy";
      fsType = "ext4";
    };

  fileSystems."/boot/efi" =
    { device = "/dev/disk/by-uuid/3AAC-0392";
      fsType = "vfat";
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
