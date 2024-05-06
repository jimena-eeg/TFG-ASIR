#!/bin/bash

# -------------------------------------------------- INSTALACIÓN LOGSTASH --------------------------------------------------

# Descargar Logstash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic-keyring.gpg

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Logstash."
    exit 1
fi

# Instalación paquete transport-https
sudo apt-get install apt-transport-https -y

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar transport-https."
    exit 1
fi

# Agregar línea de configuración al repositorio de ElasticSearch
echo "deb [signed-by=/usr/share/keyrings/elastic-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-8.x.list

# Instalación Logstash
sudo apt-get update && sudo apt-get install logstash -y

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Logstash."
    exit 1
fi

# Cambiar el usuario y grupo en el archivo logstash.service
sudo sed -i 's/User=logstash/ User=root/g' /lib/systemd/system/logstash.service && sudo sed -i 's/Group=logstash/ Group=root/g' /lib/systemd/system/logstash.service

# Verificar modificación archivo logstash.service
if [ $? -ne 0 ]; then
    echo "Error: No se pudo modificar correctamente el archivo archivo logstash.service."
    exit 1
fi

# # Copiar archivos de configuración
sudo cp ./logstash.yml /etc/logstash/ && sudo cp ./pipelines.yml /etc/logstash/ && sudo mv ./logstash-*.conf /etc/logstash/conf.d/

# Obtener la contraseña de la variable de entorno ELASTIC_PASSWORD
contrasena_nueva=$(sudo cat /etc/elasticsearch/contrasena_elastic.txt)

# Reemplazar la contraseña en el archivo de configuración
sudo sed -i "s/password => \"pidRORInvF+LRc1l4qZH\"/password => \"$contrasena_nueva\"/" "/etc/logstash/conf.d/logstash-filebeat.conf"
sudo sed -i "s/password => \"pidRORInvF+LRc1l4qZH\"/password => \"$contrasena_nueva\"/" "/etc/logstash/conf.d/logstash-metricbeat.conf"
sudo sed -i "s/password => \"pidRORInvF+LRc1l4qZH\"/password => \"$contrasena_nueva\"/" "/etc/logstash/conf.d/logstash-packetbeat.conf"

# Verificar copia archivos de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudieron copiar los archivos de configuración de Logstash."
    exit 1
fi

# Mensaje ejecución exitosa LOGSTASH
echo "LOGSTASH: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt
