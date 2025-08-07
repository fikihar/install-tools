#!/bin/bash

# URL GitHub kamu
REPO_URL="https://raw.githubusercontent.com/fikihar/install-tools/main"

while true; do
  clear
  echo "==============================="
  echo "   MENU INSTALASI OTOMATIS"
  echo "==============================="
  echo "1. Enable .htaccess"
  echo "2. Ganti Port Apache"
  echo "3. Install Ioncube Loader"
  echo "4. Ganti Kernel (Generic)"
  echo "5. Install Swap dan Asterisk"
  echo "6. Setup VPN di VPS"
  echo "7. Keluar"
  echo "-------------------------------"
  read -p "Masukkan pilihan [1-7]: " pilihan

  case $pilihan in
    1)
      curl -sO $REPO_URL/enablehtaccess.sh && chmod +x enablehtaccess.sh && ./enablehtaccess.sh
      ;;
    2)
      curl -sO $REPO_URL/ganti-port.sh && chmod +x ganti-port.sh && ./ganti-port.sh
      ;;
    3)
      curl -sO $REPO_URL/ioncube.sh && chmod +x ioncube.sh && ./ioncube.sh
      ;;
    4)
      curl -sO $REPO_URL/kernel.sh && chmod +x kernel.sh && ./kernel.sh
      ;;
    5)
      curl -sO "$REPO_URL/swap-dan-asterisk.sh" && chmod +x swap-dan-asterisk.sh && ./swap-dan-asterisk.sh
      ;;
    6)
      curl -sO $REPO_URL/vpn-vps.sh && chmod +x vpn-vps.sh && ./vpn-vps.sh
      ;;
    7)
      echo "Keluar dari installer."
      exit 0
      ;;
    *)
      echo "❌ Pilihan tidak valid. Silakan masukkan angka 1 sampai 7."
      ;;
  esac

  echo
  read -p "Tekan Enter untuk kembali ke menu..."
done
