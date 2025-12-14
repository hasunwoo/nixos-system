{ config, pkgs, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";

    boot.initrd.availableKernelModules = [
        # 공통 스토리지
        "ahci"
        "nvme"
        "sd_mod"
        "sr_mod"
        "usb_storage"

        # Device mapper
        "dm_mod"
        "dm_crypt"

        # Virt (KVM/QEMU)
        "virtio_pci"
        "virtio_blk"
        "virtio_scsi"
        "virtio_net"

        # Hyper-V
        "hv_vmbus"
        "hv_storvsc"

        # VMware
        "vmw_pvscsi"
    ];

    boot.initrd.supportedFilesystems = [
        "ext4"
        "btrfs"
        "vfat"
        "xfs"
    ];

    boot.loader.timeout = 3;
}

