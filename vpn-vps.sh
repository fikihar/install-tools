#!/bin/bash

set -e

echo "=== Menginstal ppp dan xl2tpd ==="
apt update
apt install -y ppp xl2tpd

echo "=== Konfigurasi /etc/xl2tpd/xl2tpd.conf ==="
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
port = 1701
ipsec saref = no

[lns default]
ip range = 10.22.1.2-10.22.1.10
local ip = 10.22.1.1
length bit = yes
require chap = yes
refuse pap = yes
require authentication = yes
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
EOF

echo "=== Konfigurasi /etc/ppp/options.xl2tpd ==="
cat > /etc/ppp/options.xl2tpd <<EOF
require-mschap-v2
refuse-chap
refuse-mschap
refuse-pap
ms-dns 8.8.8.8
ms-dns 8.8.4.4
nodefaultroute
mtu 1400
mru 1400
debug
lock
EOF

echo "=== Konfigurasi /etc/ppp/chap-secrets ==="
cat > /etc/ppp/chap-secrets <<EOF
admin    *    1234    *
EOF

echo "=== Restart layanan xl2tpd ==="
systemctl restart xl2tpd
systemctl enable xl2tpd

echo "=== Status Layanan ==="
systemctl status xl2tpd --no-pager

echo "=== Selesai ==="
