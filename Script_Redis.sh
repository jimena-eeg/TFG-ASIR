#!/bin/bash

# -------------------------------------------------- INSTALACIÓN REDIS --------------------------------------------------

# Instalación Redis
sudo apt install redis-server -y

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Redis."
    exit 1
fi

# Copiar archivo de configuración
sudo cp ./redis.conf /etc/redis/

# Verificar copia archivo de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo de configuración."
    exit 1
fi

# Mensaje ejecución exitosa Redis
echo "REDIS: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt