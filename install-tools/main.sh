#!/bin/bash

# URL GitHub tempat semua file skrip disimpan (di root repo)
REPO_URL="https://raw.githubusercontent.com/fikihar/install-tools/main/install-tools"

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
    1) FILE="enablehtaccess.sh" ;;
    2) FILE="ganti-port.sh" ;;
    3) FILE="ioncube.sh" ;;
    4) FILE="kernel.sh" ;;
    5) FILE="swap-dan-asterisk.sh" ;;
    6) FILE="vpn-vps.sh" ;;
    7)
      echo "Keluar dari installer."
      exit 0
      ;;
    *)
      echo "❌ Pilihan tidak valid. Silakan masukkan angka 1 sampai 7."
      read -p "Tekan Enter untuk kembali ke menu..."
      continue
      ;;
  esac

  echo "📥 Mengunduh skrip: $FILE ..."
  curl -fsSLO "$REPO_URL/$FILE"

  if [[ -f "$FILE" ]]; then
    chmod +x "$FILE"
    echo "🚀 Menjalankan skrip $FILE..."
    ./"$FILE"
    rm "$FILE"
  else
    echo "❌ Gagal mengunduh skrip dari $REPO_URL/$FILE"
  fi

  echo
  read -p "Tekan Enter untuk kembali ke menu..."
done
