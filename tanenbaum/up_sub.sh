#!/bin/bash

sudo tcpdump -i eth0 host 192.168.1.103 and port 1883 -w log_sub &

mosquitto_sub -h 192.168.1.102 -t sensor/temperatura/

echo "Passou sub"

#tcpdump_num="$(ps aux | grep tcpdump | sed 1'!d' | cut -d" " -f7)"
#sudo kill $tcpdump_num

exit 0
