#! /bin/bash

# Crear MENÚ
menu ()
{
   #Declaración de variables
   controlador=0
   while [ $controlador -eq 0 ]
   do
      #Imprime menú por pantalla
      echo " ---------- MENÚ ----------"
      echo -e
      echo "1) Instalacción para Nodo central (controlador)"
      echo "2) Instalación para cliente a monitorizar"
      echo "3) Puesta en marcha del controlador"
      echo "4) Salir"
      echo -e
      #Lee opción elegida
      read -p "Elige una opción: " opcion

      #Comprueba opción introducida y ejecuta opción elegida
      case $opcion in
         1) confirmacion "1";;
         2) confirmacion "2";;
         3) inicializacion;;
         4) controlador=1;;
         *) echo "Opción no válida"
      esac
   done
}

# Función Confirmación Instalación
confirmacion ()
{
    # Muestra mensaje de confirmación para la instalación
    if [ $1 == '1' ];then
        #Solicita confirmación de instalación completa
        read -p "¿DESEA REALIZAR LA INSTALACIÓN PARA EL NODO CENTRAL?(s/n) " confirmacioncompleta

        #Comprueba opción introducida y ejecuta opción elegida
        case $confirmacioncompleta in
            s) completa;;
            S) completa;;
            *) menu;;
        esac
    else
        #Solicita confirmación de instalación cliente
        read -p "¿DESEA REALIZAR LA INSTALACIÓN PARA MONITORIZAR COMO CLIENTE?(s/n) " confirmacioncliente

        #Comprueba opción introducida y ejecuta opción elegida
        case $confirmacioncliente in
            s) cliente;;
            S) cliente;;
            *) menu;;
        esac
    fi
}

# Función Instalación Completa
completa ()
{
    # Instalaciones previas
    sudo bash ./Script_Instalaciones_Previas.sh
    # Instalación Elasticsearch
    sudo bash ./Script_Elasticsearch.sh
    # Instalación Kibana
    sudo bash ./Script_Kiabana.sh
    # Instalación Beats
    sudo bash ./Script_Beats.sh
    # Instalación Redis
    sudo bash ./Script_Redis.sh
    # Instalación Logstash
    sudo bash ./Script_Logstash.sh
    # Habilitar servicios
    sudo bash ./Script_Habilitar.sh 1
}

# Función Instalación Cliente
cliente ()
{
    # Expresión regular para verificar el formato de la dirección IP
    local ip_regex='^([0-9]{1,3}\.){3}[0-9]{1,3}$'

    # Solicita y comprueba IP del nodo principal
    while true; do
        read -p "Por favor, introduzca la IP del controlador: " ip
        # Validar la dirección IP
        if [[ $ip =~ $ip_regex ]]; then
            break  # Salir del bucle si la dirección IP es válida
        else
            echo "La dirección IP ingresada no es válida."
        fi
    done

    # Instalaciones previas
    sudo bash ./Script_Instalaciones_Previas.sh
    # Instalación Beats
    sudo bash ./Script_Beats.sh $ip
    # Habilitar servicios
    sudo bash ./Script_Habilitar.sh 2
}

# Función inicialización controlador
inicializacion ()
{
    # Reinidio de los servicios
    sudo systemctl restart filebeat.service
    sudo systemctl restart metricbeat.service
    sudo systemctl restart packetbeat.service
    sudo systemctl restart redis.service
    sudo systemctl restart redis-server.service
    sudo systemctl restart logstash.service
    sudo systemctl restart elasticsearch.service
    sudo systemctl restart kibana.service

    # Obtener token de inscripción para Kibana
    sudo /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana | sudo tee /etc/elasticsearch/token_kibana.txt >/dev/null

}

# ------------------------------  COMIENZO EJECUCIÓN  ------------------------------

# Borra pantalla
clear

# Ejecuta el menú
menu
