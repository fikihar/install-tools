#!/bin/bash
set -e

echo "[INFO] Update paket..."
apt update -y

echo "[INFO] Install kernel generic terbaru..."
apt install -y linux-image-amd64

echo "[INFO] Mencari versi kernel generic terbaru..."
GENERIC_KERNEL=$(ls /boot/vmlinuz-*amd64 | grep -v cloud | sort -V | tail -n 1)

if [ -z "$GENERIC_KERNEL" ]; then
    echo "[ERROR] Kernel generic tidak ditemukan. Proses dihentikan."
    exit 1
fi

KERNEL_VERSION=$(basename "$GENERIC_KERNEL" | sed 's/vmlinuz-//')
echo "[INFO] Kernel generic ditemukan: $KERNEL_VERSION"

echo "[INFO] Mengubah GRUB agar default boot ke kernel generic..."
sed -i "s|^GRUB_DEFAULT=.*|GRUB_DEFAULT=\"Advanced options for Debian GNU/Linux>Debian GNU/Linux, with Linux $KERNEL_VERSION\"|" /etc/default/grub

echo "[INFO] Update GRUB..."
update-grub

echo "[INFO] Selesai. Silakan reboot VPS untuk mencoba kernel generic."
echo "Peringatan: Jika setelah reboot masih boot ke kernel cloud, berarti provider mengunci kernel di hypervisor."
