```bash
# Ubah port di ports.conf
sudo sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf

# Ubah port di virtual host default
sudo sed -i 's/<VirtualHost \*:80>/<VirtualHost *:8080>/' /etc/apache2/sites-available/000-default.conf

# Restart Apache
sudo systemctl restart apache2