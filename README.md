# Laboratorio de Automatización de Infraestructura (DevOps) - Inmatic

Este repositorio centraliza las herramientas y flujos de trabajo que he desarrollado para gestionar el ciclo de vida de servidores y aplicaciones en el entorno de **Inmatic**. El objetivo principal es la transición hacia un modelo de **Infraestructura como Código (IaC)**, eliminando tareas manuales en el despliegue de recursos.

## 📁 Estructura del Proyecto

El repositorio está organizado en módulos independientes que se integran para formar una solución completa:

* **`terraform_docker_lab/`**: Núcleo de orquestación. Gestiona el aprovisionamiento de contenedores Docker y la creación de máquinas virtuales en **vSphere 8.0.3**.
* **`ansible_lab/`**: Capa de gestión de configuración. Define el estado deseado de los sistemas operativos y aplica normativas de endurecimiento (hardening).
* **`scripts_ubuntu_lab/`**: Repositorio de scripts Bash para tareas de mantenimiento rápido, incluyendo la automatización de la puesta a punto inicial (`get_ready.sh`).
* **`sql_lab/`**: Automatización de bases de datos MariaDB/MySQL mediante contenedores, facilitando entornos de persistencia de datos.
* **`security_lab/`**: Auditoría y seguridad orientada a identificar y cerrar brechas en servidores de nueva creación.

## 🛰️ Especificaciones del Entorno Técnico

El despliegue se realiza sobre una infraestructura física con las siguientes características:

| Componente | Detalle Técnico |
| :--- | :--- |
| **Datacenter** | Inmatic |
| **Clúster** | Clúster ESXI's Inmatic |
| **Almacenamiento** | `datastore2 (1)` con 6,97 TB disponibles |
| **Recursos de Memoria** | ~963 GB libres en el pool de recursos |
| **Red de Datos** | `VM Network` |

## 🚀 Flujo de Trabajo: Despliegue Híbrido

He implementado un flujo de trabajo que integra la creación de hardware virtual con la configuración automática del software:

1. **Aprovisionamiento (Terraform)**: Se clona la máquina virtual `VM-Terraform-Yerai` a partir de la plantilla `PlantillaDev`. Durante este proceso, se configura el firmware en modo **EFI** para asegurar la compatibilidad con el sistema de archivos.
2. **Identificación de Red**: vCenter asigna una IP dinámica (ej. `192.168.68.74`) y el sistema espera a que el servicio esté disponible para la conexión remota.
3. **Post-Configuración (Ansible)**: Mediante un provisionador `local-exec`, Terraform dispara automáticamente los playbooks de Ansible. Estos se encargan de ejecutar el script `get_ready.sh`, que realiza la actualización del sistema, instala **Docker Engine** y configura alias de administración personalizados.

## 📝 Notas de Implementación

* **Seguridad de Secretos**: Los archivos de variables sensibles (`secretos.auto.tfvars`) están excluidos del control de versiones para proteger las credenciales del vCenter y los usuarios de las plantillas.
* **Requisitos Previos**: El uso de este laboratorio requiere tener instalados `terraform`, `ansible` y `sshpass` en la estación de trabajo local para garantizar una ejecución fluida.

---
**Estado del Proyecto:** Operativo / Entorno de Desarrollo.