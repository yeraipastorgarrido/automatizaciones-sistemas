# Scripts Lab: Automatización de Sistemas Ubuntu/Debian

Este directorio centraliza los scripts de Bash que utilizo para agilizar la administración y el mantenimiento de las instancias Linux en el entorno de **Inmatic**. El objetivo es estandarizar la configuración inicial de cualquier servidor recién desplegado para que sea operativo en cuestión de minutos.

## 🛠️ Script Principal: `get_ready.sh`

Este es el script de "puesta a punto" que ejecuto (generalmente vía Ansible) cada vez que Terraform crea una nueva máquina virtual. Automatiza las tareas más tediosas del post-despliegue.

### Funcionalidades clave:
* **Actualización del Sistema:** Realiza un `apt update` y `upgrade` completo para asegurar que el servidor nace parcheado.
* **Stack de Herramientas:** Instala paquetes esenciales para administración y diagnóstico (`git`, `vim`, `curl`, `net-tools`, `traceroute`).
* **Entorno de Contenedores:** Instala y habilita el motor de **Docker**, añadiendo el usuario actual al grupo de docker para evitar el uso constante de sudo.
* **Personalización de Bash:** Inyecta alias personalizados (`estado_disco`, `archivos_permisos`) para mejorar la agilidad en la terminal.
* **Refresco de Interfaz:** Reinicia el servicio `gdm3` para asegurar que el entorno gráfico responda correctamente en la consola de VMware.

## 📋 Instrucciones de Uso

El script está diseñado para ser invocado de dos maneras:

1. **Automática (vía Ansible):** Terraform llama a un playbook que transfiere y ejecuta este script tras detectar la IP de la VM.
2. **Manual:** Para máquinas existentes, se puede ejecutar directamente:
   ```bash
   chmod +x get_ready.sh
   ./get_ready.sh