#!/bin/bash

NOMBRE="mysql-container"
PASS="yerai2025!"
ARCHIVO="inventario.sql"

if [ "$(docker ps -q -f name=$NOMBRE)" ]; then
    echo "El contenedor $NOMBRE ya está funcionando."
else
    if [ "$(docker ps -aq -f name=$NOMBRE)" ]; then
        echo "Arrancando contenedor existente..."
        docker start $NOMBRE
    else
        echo "Creando contenedor nuevo desde cero..."
        docker run --name $NOMBRE -e MYSQL_ROOT_PASSWORD=$PASS -p 3306:3306 -d mysql:latest
        echo "Esperando 20 segundos a que el motor arranque..."
        sleep 20
    fi
fi

if [ -f "$ARCHIVO" ]; then
    echo "Intentando importar $ARCHIVO..."
    docker exec -i $NOMBRE mysql -u root -p$PASS < $ARCHIVO
    if [ $? -eq 0 ]; then
        echo "✅ ¡Base de datos y tablas creadas con éxito!"
    else
        echo "❌ Error en la importación. Revisa el archivo SQL."
    fi
else
    echo "Falta el archivo $ARCHIVO en la carpeta."
fi