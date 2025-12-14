#!/usr/bin/env bash
set -euo pipefail

DISK="$1"
EFI_SIZE="1G"

# GPT
parted -s "$DISK" mklabel gpt
parted -s "$DISK" mkpart ESP fat32 1MiB "$EFI_SIZE"
parted -s "$DISK" set 1 esp on
parted -s "$DISK" mkpart primary btrfs "$EFI_SIZE" 100%

partprobe "$DISK"
sleep 1

EFI_PART="$(lsblk -ln -o NAME "$DISK" | sed -n '2p' | sed "s|^|/dev/|")"
ROOT_PART="$(lsblk -ln -o NAME "$DISK" | sed -n '3p' | sed "s|^|/dev/|")"

mkfs.vfat -F32 "$EFI_PART"
mkfs.btrfs -f "$ROOT_PART"

# mount root fs to create subvols
mount "$ROOT_PART" /mnt
btrfs subvolume create /mnt/@root
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@swap
umount /mnt

# mount subvols
mount -o subvol=@root,compress=zstd,noatime "$ROOT_PART" /mnt
mkdir -p /mnt/{boot/efi,home,nix,swap}
mount "$EFI_PART" /mnt/boot/efi
mount -o subvol=@home,compress=zstd,noatime "$ROOT_PART" /mnt/home
mount -o subvol=@nix,compress=zstd,noatime "$ROOT_PART" /mnt/nix
mount -o subvol=@swap,noatime "$ROOT_PART" /mnt/swap

# swapfile
btrfs filesystem mkswapfile --size 32G /mnt/swap/swapfile

# UUID facts
BTRFS_UUID="$(blkid -s UUID -o value "$ROOT_PART")"
EFI_UUID="$(blkid -s UUID -o value "$EFI_PART")"

mkdir -p /mnt/etc/nixos/secrets
cat > /mnt/etc/nixos/secrets/disks.nix <<EOF
{
  btrfsRoot = "/dev/disk/by-uuid/$BTRFS_UUID";
  efi       = "/dev/disk/by-uuid/$EFI_UUID";
  swap      = "/swap/swapfile";
}
EOF

chmod 600 /mnt/etc/nixos/secrets/disks.nix
