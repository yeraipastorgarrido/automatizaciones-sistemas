# Ansible Lab: Gestión de Configuración y Estados

Este directorio contiene los playbooks y archivos de configuración necesarios para automatizar el estado deseado de las máquinas virtuales y servidores locales.

## 📋 Contenido del Módulo

* **`get_vmware_ready.yml`**: Playbook principal de post-despliegue. Actúa como orquestador para ejecutar scripts de inicialización en máquinas recién creadas por Terraform.
* **`hardening.yml`**: Playbook dedicado a la seguridad del sistema operativo, aplicando políticas de cierre de puertos y configuraciones seguras de SSH.
* **`hosts.ini`**: Inventario de nodos gestionados, organizado por grupos (ej. servidores web, bases de datos).
* **`pruebas_ansible.yml`**: Entorno de testing para validar conectividad y nuevos módulos antes de pasarlos a producción.

## ⚙️ Uso
Para ejecutar la configuración de una VM específica tras su despliegue:
```bash
ansible-playbook -i 'IP_DE_LA_VM,' -u yerai -e 'ansible_password=TU_PASSWORD' get_vmware_ready.yml