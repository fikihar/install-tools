#!/bin/bash

set -e

echo "🔧 Mengaktifkan .htaccess di Apache..."

# 1. Aktifkan modul rewrite
echo "✅ Mengaktifkan modul rewrite..."
a2enmod rewrite

# 2. Ubah konfigurasi Apache agar AllowOverride All aktif
echo "📝 Mengubah /etc/apache2/sites-available/000-default.conf..."

CONF_FILE="/etc/apache2/sites-available/000-default.conf"
if grep -q "AllowOverride All" "$CONF_FILE"; then
  echo "ℹ️  AllowOverride All sudah diatur."
else
  sed -i '/DocumentRoot \/var\/www\/html/a \
    <Directory /var/www/html>\n\
        AllowOverride All\n\
        Require all granted\n\
    </Directory>' "$CONF_FILE"
  echo "✅ AllowOverride All ditambahkan."
fi

# 3. Restart Apache
echo "🔄 Restart Apache..."
systemctl restart apache2

# 4. Verifikasi
echo "✅ .htaccess sekarang aktif!"
