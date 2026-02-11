#!/bin/bash

# ==========================================================
# Script de limpieza del entorno para el laboratorio de SQL
# ==========================================================

NOMBRE="mysql-container"

echo "Iniciando limpieza profunda del entorno..."

docker rm -f -v $NOMBRE 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Sistema purgado correctamente."
else
    echo "No se encontro ningun contenedor para limpiar o ya estaba borrado."
fi