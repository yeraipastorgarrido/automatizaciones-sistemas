# Laboratorio de Automatización: Terraform + VMware + Ansible

Este proyecto automatiza el despliegue de infraestructura en un entorno **VMware vSphere** y la configuración post-despliegue mediante **Ansible**.

## 🚀 Componentes
- **Terraform**: Orquestación de la infraestructura en el Datacenter `Inmatic`.
- **VMware vCenter**: Gestión del clúster `Clúster ESXI's Inmatic`.
- **Ansible**: Configuración automática de la VM (Docker, herramientas y alias).
- **Docker**: Despliegue de un contenedor Nginx local como prueba de concepto.

## 🛠️ Requisitos
- Acceso al vCenter en la IP `192.168.68.81`.
- Plantilla de VM denominada `PlantillaDev`.
- Instalar `sshpass` y `ansible` en la máquina local.

## 📈 Flujo de Trabajo
1. `terraform apply` clona la plantilla y enciende la VM.
2. Terraform captura la IP asignada (ej: `192.168.68.74`).
3. Se ejecuta automáticamente el script `get_ready.sh` vía Ansible.