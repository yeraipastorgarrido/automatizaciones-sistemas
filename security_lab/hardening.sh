#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
  echo "Error: Este script debe ejecutarse con sudo."
  exit 1
fi

echo "Iniciando proceso de Hardening del servidor..."

echo "Actualizando parches de seguridad..."
apt update && apt upgrade -y

echo "Configurando Firewall (UFW)..."
ufw default deny incoming
ufw default allow outgoing

ufw allow ssh

ufw allow 3306/tcp

echo "y" | ufw enable

echo "Reforzando configuración de SSH..."

sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

systemctl restart ssh

echo "RESULTADO: Hardening básico completado."
echo "Reglas de Firewall activas:"
ufw status