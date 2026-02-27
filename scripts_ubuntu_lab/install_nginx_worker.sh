#!/bin/bash
# install_nginx_worker.sh

# 1. Esperar a que el sistema esté libre
while fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1 ; do
    echo "Esperando a que se desbloquee apt..."
    sleep 5
done

# 2. Limpiar firewalls a nivel de kernel
sudo ufw disable
sudo iptables -F

# 3. Instalar Nginx
sudo apt-get update
sudo apt-get install -y nginx

# 4. Personalizar el index con el nombre de la máquina
echo "<h1>Backend: $(hostname)</h1>" | sudo tee /var/www/html/index.html

# 5. Asegurar que arranque
sudo systemctl enable nginx
sudo systemctl restart nginx