{ config, lib, pkgs, secretsPath, ... }:
let
    disks = import /etc/nixos/secrets/disks.nix;
in
{
    fileSystems."/" = {
        device = disks.btrfsRoot;
        fsType = "btrfs";
        options = [
            "subvol=@root"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/home" = {
        device = disks.btrfsRoot;
        fsType = "btrfs";
        options = [
            "subvol=@home"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/nix" = {
        device = disks.btrfsRoot;
        fsType = "btrfs";
        options = [
            "subvol=@nix"
            "compress=zstd"
            "noatime"
        ];
    };

    fileSystems."/swap" = {
        device = disks.btrfsRoot;
        fsType = "btrfs";
        options = [
            "subvol=@swap"
            "noatime"
        ];
    };

    fileSystems."/boot/efi" = {
        device = disks.efi;
        fsType = "vfat";
    };

    swapDevices = [
        { device = disks.swap; }
    ];
}
