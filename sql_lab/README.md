# Laboratorio: Inventario IT Automatizado (Docker + MySQL)

Este laboratorio automatiza la creación de un entorno de base de datos para gestión de activos informáticos.

## Características Técnicas
* **Infraestructura**: Despliegue mediante Docker y Docker Compose.
* **Base de Datos**: Motor MySQL con triggers de seguridad para evitar el borrado de equipos en estado 'OPERATIVO'.
* **Automatización**: Scripts de Bash interactivos para limpieza (`reset_entorno.sh`) y despliegue (`levantar_docker.sh`).

## Resolución de Desafíos (Troubleshooting)
Durante el desarrollo se solventaron problemas críticos de administración:
1. **Compatibilidad**: Migración de dependencias de Python/distutils hacia Docker Compose Plugin oficial.
2. **Idempotencia**: Implementación de lógica `DROP TABLE IF EXISTS` para evitar el error 1050 de tablas duplicadas.
3. **Seguridad silenciosa**: Uso de variables de entorno para evitar avisos de contraseñas en texto plano en la terminal.

## Uso
Ejecutar el script principal y seguir las instrucciones en pantalla:
```bash
./levantar_docker.sh