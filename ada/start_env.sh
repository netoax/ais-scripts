#!/bin/bash

# Acessar Cerf (Broker) e Subir Broker
#ssh 192.168.1.110 'mosquitto -v &'
echo "Broker ON - Passo 1 OK"

# Acessar Tanenbaum (Subscriber), Subir TCPDump e Subir Subscriber
ssh upe@192.168.0.112 'nohup bash /home/pi/ais-scripts/tanenbaum/up_sub.sh >/dev/null &'
echo "SUB/TCPDUMP ON - Passo 2 OK"

sleep 5

# Acessar Kurose
ssh pi@192.168.0.111 'bash /home/pi/ais-scripts/kurose/publish.sh'
#echo "PUB DONE - Passo 3 OK"

# Copiar log (Tanembaum -> Ada) e (Kurose -> Ada)
# ssh 192.168.1.103 'scp /home/pi/scripts/log_sub 192.168.1.100' 
# ssh 192.168.1.101 'scp /home/pi/scripts/log_pub 192.168.1.100'
# echo "Passo 4 OK"

ssh upe@192.168.0.110 'bash /home/pi/ais-scripts/tanenbaum/exit.sh'
ssh pi@192.168.0.111 'bash /home/pi/ais-scripts/kurose/exit.sh'
echo "PUB and SUB exit all - Passo 4 OK"

# Fechar todos os processos em execução (fazer análise depois)
# ssh 192.168.1.103 'bash /home/pi/scripts/exit.sh'
#ssh upe@192.168.0.110 'bash /home/pi/ais-scripts/tanenbaum/exit.sh'
