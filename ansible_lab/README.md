# Laboratorio de Ansible

Este módulo se enfoca en la gestión de configuraciones y la orquestación de tareas en servidores remotos mediante playbooks de Ansible.

## Contenido Técnico
* **pruebas_ansible.yml**: Playbook diseñado para la ejecución de comandos remotos y la gestión de estados en nodos externos.

## Funcionalidades Implementadas
* **Gestión de archivos**: Automatización de la transferencia y sincronización de ficheros.
* **Módulo Fetch**: Extracción de informes y logs desde los nodos remotos hacia la máquina de control para su posterior análisis.
* **Idempotencia**: Garantía de que el estado del sistema final es el deseado independientemente de las ejecuciones previas.