# Laboratorio: Inventario IT Automatizado

Este módulo automatiza el despliegue de un servidor de base de datos MySQL mediante contenedores Docker, incluyendo scripts de gestión interactivos.

## Funcionalidades Técnicas
* **Ciclo de vida de contenedores:** Gestión completa del estado del servicio (levantado, parada y purgado).
* **Idempotencia:** Scripts diseñados para ejecutarse múltiples veces sin errores de duplicidad.
* **Seguridad en DB:** Implementación de triggers para evitar el borrado accidental de equipos en estado 'OPERATIVO'.

## Requisitos y Despliegue
1. Docker Engine.
2. Ejecutar `./levantar_docker.sh`.