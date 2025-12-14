{ config, pkgs, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    boot.initrd.availableKernelModules = [
        "ahci"
        "sd_mod"
        "usb_storage"
        "nvme"
    ];

    boot.initrd.kernelModules = [
        "btrfs"
    ];

    boot.loader.timeout = 3;
}

