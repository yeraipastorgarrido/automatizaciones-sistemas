#!/bin/bash

# ==========================================================
# Script de puesta a punto para Debian/Ubuntu
# Hecho por Yerai Pastor (para no repetir siempre lo mismo)
# ==========================================================

# Colores para que la terminal no sea un aburrimiento
VERDE='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${VERDE}1. Actualizando el sistema...${NC}"
sudo apt update && sudo apt upgrade -y

echo -e "${VERDE}2. Instalando herramientas básicas que siempre faltan...${NC}"
# Meto Git, Vim, Curl y cosillas de red que usamos en ASIR
sudo apt install -y git vim curl wget net-tools traceroute build-essential

echo -e "${VERDE}3. Instalando Docker (que luego siempre se me olvida)...${NC}"
sudo apt install -y docker.io
sudo systemctl enable --now docker
# Me añado al grupo docker para no usar sudo siempre
sudo usermod -aG docker $USER

echo -e "${VERDE}4. Limpiando morralla...${NC}"
sudo apt autoremove -y

echo -e "${VERDE}5. Configurando un par de alias cómodos...${NC}"
# Para que 'll' funcione y ver el espacio de disco más bonito
echo "alias ll='ls -la'" >> ~/.bashrc
echo "alias df='df -h'" >> ~/.bashrc

echo -e "${VERDE}¡Listo! Máquina preparada. Reinicia la sesión para los alias.${NC}"