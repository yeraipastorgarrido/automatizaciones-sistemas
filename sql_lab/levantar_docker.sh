#!/bin/bash

# ==========================================================
# Script de instalación y gestión del entorno Docker para el laboratorio de SQL
# ==========================================================

NOMBRE="mysql-container"
PASS="yerai2025!"
ARCHIVO="inventario.sql"

read -p "Quieres limpiar el entorno antes de empezar? (s/n): " opcion

if [[ "$opcion" == "s" || "$opcion" == "S" ]]; then
    if [ -f "reset_entorno.sh" ]; then
        bash reset_entorno.sh
    else
        docker rm -f -v $NOMBRE 2>/dev/null
    fi

    echo "Creando contenedor nuevo..."
    docker run --name $NOMBRE -e MYSQL_ROOT_PASSWORD=$PASS -p 3306:3306 -d mysql:latest
    echo "Esperando 10 segundos para la carga del motor..."
    sleep 10

    if [ -f "$ARCHIVO" ]; then
        echo "Importando inventario inicial..."
        docker exec -i -e MYSQL_PWD=$PASS $NOMBRE mysql -u root < $ARCHIVO
        echo "RESULTADO: Instalacion limpia completada."
        docker exec -it -e MYSQL_PWD=$PASS $NOMBRE mysql -u root -D gestion_it -e "SELECT * FROM equipos;"
    else
        echo "Error: No se encontro el archivo $ARCHIVO para la instalacion limpia."
    fi

else
    echo "Verificando existencia del entorno..."
    
    if [ "$(docker ps -aq -f name=$NOMBRE)" ]; then
        echo "Contenedor detectado. Iniciando servicios..."
        docker start $NOMBRE >/dev/null
        
        echo "Entorno recuperado. Estado actual del inventario:"
        docker exec -it -e MYSQL_PWD=$PASS $NOMBRE mysql -u root -D gestion_it -e "SELECT * FROM equipos;"
    else
        echo "Error: El entorno no existe. Debes seleccionar 's' para crearlo primero."
        exit 1
    fi
fi