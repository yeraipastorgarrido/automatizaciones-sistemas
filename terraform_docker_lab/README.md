# Terraform Lab: Orquestación Híbrida

Este directorio es el punto de entrada para el despliegue de infraestructura. Gestiona la conexión con el entorno de **vSphere 8.0.3** y el motor de **Docker** local.

## 🏗️ Recursos Gestionados
* **VMware**: Clonado de la `PlantillaDev` hacia instancias productivas en el datacenter Inmatic.
* **Docker**: Despliegue de servicios auxiliares como servidores Nginx para pruebas de carga.

## 🔑 Archivos de Configuración
* **`vmware.tf`**: Definición de hardware virtual (vCPU, RAM, Firmware EFI).
* **`docker.tf`**: Gestión de imágenes y contenedores.
* **`secretos.auto.tfvars`**: (Excluido de Git) Contiene las credenciales de administrador y claves de acceso de red.

## 🚦 Despliegue
```bash
terraform init
terraform apply -auto-approve