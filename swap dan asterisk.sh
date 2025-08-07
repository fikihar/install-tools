#!/bin/bash

# ============================
# 1. Tambah Swap 2GB
# ============================

SWAP_SIZE=2G
SWAP_FILE=/swapfile

echo "=== Mengecek apakah swap sudah aktif ==="
if swapon --show | grep -q "$SWAP_FILE"; then
    echo "Swap sudah aktif di $SWAP_FILE"
else
    echo "=== Membuat swap sebesar $SWAP_SIZE ==="
    fallocate -l $SWAP_SIZE $SWAP_FILE || dd if=/dev/zero of=$SWAP_FILE bs=1M count=2048 status=progress
    chmod 600 $SWAP_FILE
    mkswap $SWAP_FILE
    swapon $SWAP_FILE
    echo "$SWAP_FILE none swap sw 0 0" >> /etc/fstab
    echo "vm.swappiness=10" >> /etc/sysctl.conf
    echo "vm.vfs_cache_pressure=50" >> /etc/sysctl.conf
    sysctl vm.swappiness=10
    sysctl vm.vfs_cache_pressure=50
    echo "Swap berhasil ditambahkan dan diaktifkan."
fi

# ============================
# 2. Download & Jalankan Installer FreePBX
# ============================

echo "=== Download installer FreePBX Debian ==="
cd /tmp
wget https://github.com/FreePBX/sng_freepbx_debian_install/raw/master/sng_freepbx_debian_install.sh -O /tmp/sng_freepbx_debian_install.sh

if [ -f /tmp/sng_freepbx_debian_install.sh ]; then
    echo "=== Menjalankan installer FreePBX ==="
    bash /tmp/sng_freepbx_debian_install.sh
else
    echo "Gagal mendownload skrip installer FreePBX!"
    exit 1
fi
