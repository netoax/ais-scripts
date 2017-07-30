#!/bin/bash

nohup sudo tcpdump -i eth0 host 192.168.1.101 and port 1883 -w log_pub &>/dev/null & sleep 2

sleep 5

for i in {1..10}
do
	mosquitto_pub -h 192.168.1.102 -t sensor/temperatura -m "mensagem $i"
done

echo "Passou pub"

#tcpdump_num="$(ps aux | grep tcpdump | sed 1'!d' | cut -d" " -f7)"
#sudo kill $tcpdump_num

exit 0
