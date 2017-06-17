#!/bin/bash

nohup sudo tcpdump -i wlan0 port 1883 -w log_sub &>/dev/null & sleep 2

echo "Ativou tcp dump -> verificar processos, esperar 5 segundos"

sleep 5

mosquitto_sub -h 192.168.0.104 -t sensor/temperatura/

echo "Passou pelo sub -> algo está errado"

#tcpdump_num="$(ps aux | grep tcpdump | sed 1'!d' | cut -d" " -f7)"
#sudo kill $tcpdump_num

exit 0
