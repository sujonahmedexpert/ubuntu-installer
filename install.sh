#!/data/data/com.termux/files/usr/bin/bash

# Ubuntu Installer - Quick Install Script
# This script downloads and installs the Ubuntu Installer tool in Termux

set -e

echo "[*] Downloading Ubuntu Installer..."
curl -fsSL https://raw.githubusercontent.com/sujonahmedexpert/ubuntu-installer/main/ubuntu-installer.sh -o $PREFIX/bin/ubuntu-installer
chmod +x $PREFIX/bin/ubuntu-installer
echo "[+] Installation complete!"
echo "[*] Run 'ubuntu-installer' to start the tool."
