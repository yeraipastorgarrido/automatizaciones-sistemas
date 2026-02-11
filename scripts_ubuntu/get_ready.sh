#!/bin/bash

# ==========================================================
# Script de puesta a punto para Debian/Ubuntu
# ==========================================================

VERDE='\033[0;32m'
NC='\033[0m'

echo -e "${VERDE}1. Actualizando el sistema${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${VERDE}2. Instalando herramientas básicas${NC}"
sudo apt install -y git vim curl wget net-tools traceroute build-essential

echo -e "${VERDE}3. Instalando Docker${NC}"
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

echo -e "${VERDE}4. Limpiando archivos innecesarios...${NC}"
sudo apt autoremove -y

echo -e "${VERDE}5. Configurando alias basicos...${NC}"
echo "alias archivos_permisos='ls -la'" >> ~/.bashrc
echo "alias estado_disco='df -h'" >> ~/.bashrc

echo -e "${VERDE}¡Listo! Máquina preparada. Reinicia la sesión para aplicar los alias.${NC}"