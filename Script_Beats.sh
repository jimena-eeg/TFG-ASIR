#!/bin/bash

# -------------------------------------------------- INSTALACIÓN FILEBEAT --------------------------------------------------

# Descargar Filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.13.2-amd64.deb

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Filebeat."
    exit 1
fi

# Instalar Filebeat
sudo dpkg -i filebeat-8.13.2-amd64.deb

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Filebeat."
    exit 1
fi

# Copiar archivo de configuración
sudo cp ./filebeat.yml /etc/filebeat/

# Verificar copia archivo de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo de configuración de Filebeat."
    exit 1
fi

# Mensaje ejecución exitosa Filebeat
echo "FILEBEAt: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt

# -------------------------------------------------- INSTALACIÓN METRICBEAT --------------------------------------------------

# Descargar Metricbeat
sudo curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-8.13.2-amd64.deb

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Metricbeat."
    exit 1
fi

# DeInstalar Metricbeat
sudo dpkg -i metricbeat-8.13.2-amd64.deb

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Metricbeat."
    exit 1
fi

# Copiar archivo de configuración
sudo cp ./metricbeat.yml /etc/metricbeat/

# Verificar copia archivo de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo de configuración de Metricbeat."
    exit 1
fi

# Mensaje ejecución exitosa Metricbeat
echo "METRCIBEAT: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt

# -------------------------------------------------- INSTALACIÓN PACKETBEAT --------------------------------------------------

# Instalación paquete Libpcap0.8 (posiblemente no necesario para version 8.13)
sudo apt-get install libpcap0.8 -y

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar libpcap0.8."
    exit 1
fi

# Descargar Packetbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-8.13.2-amd64.deb

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Packetbeat."
    exit 1
fi

# Instalar Packetbeat
sudo dpkg -i packetbeat-8.13.2-amd64.deb

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Packetbeat."
    exit 1
fi

# Copiar archivo de configuración
sudo cp ./packetbeat.yml /etc/packetbeat/

# Verificar copia archivo de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo de configuración de Packetbeat."
    exit 1
fi

# Mensaje ejecución exitosa Packetbeat
echo "PACKETBEAT: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt

# -------------------------------------------------- MODIFICACIÓN IP --------------------------------------------------

# Modifica la IP en los archivos de configuración si se trata de un cliente
if [ $# -gt 0 ]; then
    sudo sed -i "s/hosts: \[\"localhost:6379\"\]/hosts: [\"$1:6379\"]/" "/etc/filebeat/filebeat.yml"
    sudo sed -i "s/hosts: \[\"localhost:6379\"\]/hosts: [\"$1:6379\"]/" "/etc/metricbeat/metricbeat.yml"
    sudo sed -i "s/hosts: \[\"localhost:6379\"\]/hosts: [\"$1:6379\"]/" "/etc/packetbeat/packketbeat.yml"
fi