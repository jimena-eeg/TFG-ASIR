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
      echo "3) Salir"
      echo -e
      #Lee opción elegida
      read -p "Elige una opción: " opcion

      #Comprueba opción introducida y ejecuta opción elegida
      case $opcion in
         1) confirmacion "1";;
         2) confirmacion "2";;
         3) controlador=1;;
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
            *) exit 1;;
        esac
    else
        #Solicita confirmación de instalación cliente
        read -p "¿DESEA REALIZAR LA INSTALACIÓN PARA MONITORIZAR COMO CLIENTE?(s/n) " confirmacioncliente

        #Comprueba opción introducida y ejecuta opción elegida
        case $confirmacioncliente in
            s) cliente;;
            S) cliente;;
            *) exit 1;;
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
    # Instalaciones previas
    sudo bash ./Script_Instalaciones_previas.sh
    # Instalación Beats
    sudo bash ./Script_Beats.sh
    # Habilitar servicios
    sudo bash ./Script_Habilitar.sh 2
}

# ------------------------------  COMIENZO EJECUCIÓN  ------------------------------

# Borra pantalla
clear

# Ejecuta el menú
menu