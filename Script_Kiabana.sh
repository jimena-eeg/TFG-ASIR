#!/bin/bash

# -------------------------------------------------- INSTALACIÓN KIBANA --------------------------------------------------

# Descargar Kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-8.13.2-amd64.deb

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Kibana."
    exit 1
fi

# Instalar Kibana
sudo dpkg -i kibana-8.13.2-amd64.deb

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Kibana."
    exit 1
fi

# Deshabilitar servicio para prevenir fallos
sudo systemctl stop kibana.service

# Inicialización de servicios
sudo /bin/systemctl daemon-reload

# Habilitar y arrancar el servicio
sudo /bin/systemctl enable kibana.service
sudo systemctl start kibana.service

# Verificar inicialización del servicio
if [ $? -ne 0 ]; then
    echo "Error: No se pudo iniciar el servicio de Kibana."
    exit 1
fi

# Mensaje ejecución exitosa Kibana
echo "KIBANA: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt