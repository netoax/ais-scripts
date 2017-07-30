#!/bin/bash

#Inicializar o ssh
/etc/init.d/ssh start

#Desabilitar o wifi
ifconfig wlan0 down

exit 0
