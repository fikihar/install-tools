#!/bin/bash

set -e

# === KONFIGURASI DASAR ===
PHP_VERSION=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')
PHP_EXT_DIR=$(php -i | grep '^extension_dir' | awk '{print $3}')
IONCUBE_DIR="/usr/local/ioncube"

echo "📦 PHP version detected: $PHP_VERSION"
echo "📁 PHP extension dir: $PHP_EXT_DIR"

# === Download ionCube Loader ===
cd /usr/local/src
wget https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz

# === Ekstrak ionCube ===
tar xzf ioncube_loaders_lin_x86-64.tar.gz
mkdir -p $IONCUBE_DIR
cp -r ioncube/* $IONCUBE_DIR

# === Copy file loader sesuai versi PHP ===
cp "$IONCUBE_DIR/ioncube_loader_lin_${PHP_VERSION}.so" "$PHP_EXT_DIR/"

# === Tambahkan ke php.ini ===
PHP_INI_FILE=$(php --ini | grep "Loaded Configuration File" | awk '{print $4}')
echo "zend_extension=$PHP_EXT_DIR/ioncube_loader_lin_${PHP_VERSION}.so" >> $PHP_INI_FILE

# === Restart Apache ===
systemctl restart apache2

# === Verifikasi ===
php -v | grep -i ioncube && echo "✅ ionCube berhasil terpasang!" || echo "❌ Gagal memuat ionCube."

