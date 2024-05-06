#!/bin/bash

# Inicialización de servicios
sudo /bin/systemctl daemon-reload

# Habilitar y arrancar servicios

if [ sys.argv[1] == '1' ]; then

    sudo /bin/systemctl enable filebeat.service
    sudo systemctl start filebeat.service

    sudo /bin/systemctl enable metricbeat.service
    sudo systemctl start metricbeat.service

    sudo /bin/systemctl enable packetbeat.service
    sudo systemctl start packetbeat.service

    sudo /bin/systemctl enable redis-server.service
    sudo systemctl restart redis-server.service

    sudo /bin/systemctl enable logstash.service
    sudo systemctl start logstash.service

elif [ sys.argv[1] == '2' ]; then

    sudo /bin/systemctl enable filebeat.service
    sudo systemctl start filebeat.service

    sudo /bin/systemctl enable metricbeat.service
    sudo systemctl start metricbeat.service

    sudo /bin/systemctl enable packetbeat.service
    sudo systemctl start packetbeat.service

fi

# Mensaje ejecución exitosa Habilitar
echo "HABILITAR: ¡Se han habilitado correctamente los servicios!" >> ./resultadoInstalacion.txt