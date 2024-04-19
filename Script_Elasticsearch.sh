#!/bin/bash
# -------------------------------------------------- INSTALACIÓN ELASTICSEARCH --------------------------------------------------

# Descargar Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.13.2-amd64.deb

# Verificar descarga
if [ $? -ne 0 ]; then
    echo "Error: No se pudo descargar Elasticsearch."
    exit 1
fi

# Instalar Elasticsearch
sudo dpkg -i elasticsearch-8.13.2-amd64.deb > ./instalacion_elasticsearch.txt

# Verificar instalación
if [ $? -ne 0 ]; then
    echo "Error: No se pudo instalar Elasticsearch."
    exit 1
fi

# Extraer la contraseña generada para el superusuario (elastic)
contrasena_elastic=$(grep -o 'The generated password for the elastic built-in superuser is : .*' ./instalacion_elasticsearch.txt | grep -o ':[[:space:]]*[^[:space:]]*$' | cut -d' ' -f2-)

# Verificar extracción de la contraseña
if [ -z "$contrasena_elastic" ]; then
    echo "Error: No se pudo extraer la contraseña de Elasticsearch."
    exit 1
fi

sudo rm ./instalacion_elasticsearch.txt

# Almacenar la contraseña de elastic
export ELASTIC_PASSWORD="$contrasena_elastic"

# Verificar almacenamiento de la contraseña en la variable de entorno
if [ $? -ne 0 ]; then
    echo "Error: No se pudo almacenar la contraseña de Elasticsearch."
    exit 1
fi

# Guardar la contraseña en un archivo
echo "$contrasena_elastic" | sudo tee /etc/elasticsearch/contrasena_elastic.txt >/dev/null

# Verificar almacenamiento de la contraseña en el archivo
if [ $? -ne 0 ]; then
    echo "Error: No se pudo guardar la contraseña en el archivo."
    exit 1
fi

# Copiar archivo de configuración
sudo cp ./elasticsearch.yml /etc/elasticsearch/

# Verificar copia archivo de configuración
if [ $? -ne 0 ]; then
    echo "Error: No se pudo copiar el archivo de configuración de Elasticsearch."
    exit 1
fi

# Deshabilitar servicio para prevenir fallos
sudo systemctl stop elasticsearch.service

# Inicialización de servicios
sudo /bin/systemctl daemon-reload

# Habilitar y arrancar el servicio
sudo /bin/systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

# Verificar inicialización del servicio
if [ $? -ne 0 ]; then
    echo "Error: No se pudo iniciar el servicio de Elasticsearch."
    exit 1
fi

# Verificar obtención del token (Kibana)
if [ $? -ne 0 ]; then
    echo "Error: No se pudo obtener el token de inscripción para Kibana."
    exit 1
fi

# Mensaje ejecución exitosa Elasticsearch
echo "ELASTICSEARCH: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt
