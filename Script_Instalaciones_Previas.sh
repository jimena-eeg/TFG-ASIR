#!/bin/bash

# Actualizar e instalar herramientas básicas
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install curl -y

# Instalación de Java
sudo apt install default-jre -y
sudo apt install default-jdk -y
java -version

# Mensaje ejecución exitosa Instalaciones Previas
echo "INSTALACIÓN PREVIA: ¡Instalación y configuración completadas exitosamente!" >> ./resultadoInstalacion.txt