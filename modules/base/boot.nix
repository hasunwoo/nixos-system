{ config, pkgs, ... }:
{
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.efi.efiSysMountPoint = "/boot/efi";
    boot.kernelParams = [ "rootflags=subvol=@root" ];

    boot.loader.timeout = 3;
}

