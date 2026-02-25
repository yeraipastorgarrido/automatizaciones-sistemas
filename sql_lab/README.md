# SQL Lab: Gestión de Bases de Datos Contenerizadas

Este módulo está dedicado al despliegue y administración de sistemas de bases de datos relacionales (MariaDB/MySQL) dentro del ecosistema de **Inmatic**. El objetivo es garantizar un entorno de datos consistente, persistente y fácil de resetear para pruebas de desarrollo.

## 🚀 Componentes del Módulo

He estructurado esta carpeta para que el despliegue de la base de datos sea lo más automatizado posible:

* **`docker-compose.yml`**: Define la infraestructura de la base de datos, incluyendo la configuración de variables de entorno, mapeo de puertos (3306) y la persistencia mediante volúmenes.
* **`inventario.sql`**: Script de inicialización que contiene la estructura de tablas y los datos de prueba iniciales; se carga automáticamente al levantar el servicio por primera vez.
* **`levantar_docker.sh`**: Script de automatización que simplifica el arranque del stack, validando el estado del motor Docker antes de lanzar el despliegue.
* **`reset_entorno.sh`**: Herramienta de utilidad para limpiar el entorno de pruebas, eliminando contenedores y volúmenes para permitir un despliegue desde cero.



## 🛠️ Integración con el Laboratorio

Este módulo está diseñado para ejecutarse sobre la infraestructura orquestada previamente en el clúster de vSphere:

1. **Infraestructura**: Terraform crea la VM en el datastore de Inmatic, aprovechando los **6,97 TB** de espacio disponible para asegurar la cuota de los volúmenes de datos.
2. **Preparación**: El script de post-despliegue `get_ready.sh` instala el motor de Docker necesario para gestionar estos servicios.
3. **Despliegue de Datos**: Una vez la instancia es operativa y cuenta con IP asignada (ej. `192.168.68.74`), este módulo levanta la capa de persistencia.

## 📋 Comandos Habituales

### Iniciar el entorno de base de datos
```bash
chmod +x levantar_docker.sh
./levantar_docker.sh
chmod +x reset_entorno.sh
./reset_entorno.sh
```bash