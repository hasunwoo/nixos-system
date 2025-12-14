#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

DISK="${1:-}"
HOST="hasunwoo-desktop"
SYS_REPO="https://github.com/hasunwoo/nixos-system.git"

NIXOS_DIR="/mnt/etc/nixos"
TMP_DIR="$(mktemp -d)"

if [[ -z "$DISK" ]]; then
  echo "Usage: $0 /dev/<disk>"
  exit 1
fi

# --- 안전 체크 ---
if lsblk -n "$DISK" | grep -q part; then
  echo "ERROR: $DISK already has partitions"
  exit 1
fi

# --- 파일시스템 초기화 ---
chmod +x "$SCRIPT_DIR/format_fs.sh"
"$SCRIPT_DIR/format_fs.sh" "$DISK"

# --- system flake를 임시 디렉터리에 clone ---
echo "Cloning system flake into temporary directory..."
git clone "$SYS_REPO" "$TMP_DIR/nixos"

# --- secrets 보존 ---
if [[ -d "$NIXOS_DIR/secrets" ]]; then
  echo "Preserving existing secrets..."
  mkdir -p "$TMP_DIR/nixos/secrets"
  cp -a "$NIXOS_DIR/secrets/." "$TMP_DIR/nixos/secrets/"
fi

# --- 배포 ---
echo "Deploying system flake to $NIXOS_DIR"
rm -rf "$NIXOS_DIR"
mkdir -p /mnt/etc
mv "$TMP_DIR/nixos" "$NIXOS_DIR"

rm -rf "$TMP_DIR"

# --- 설치 ---
# 설치 시 임시로 링크
ln -s /mnt/etc/nixos/secrets /etc/nixos/secrets
nixos-install --flake "$NIXOS_DIR#$HOST" --impure

# root 잠금
nixos-enter --root /mnt
passwd -l root
exit

echo "Install complete. Rebooting..."
reboot
