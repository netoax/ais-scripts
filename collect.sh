#!/bin/bash

arq="log.txt"

len="$(wc $arq | cut -d" " -f3)"

tempo_inicial="1"
timestamp=""
esp_ack=""

for ((i=1; i<$len; i++))
do
	line="$(sed $i'!d' $arq)"

	param="$(echo $line | cut -d" " -f7)"

	if [ $param = '[P.],' ]
	then

		timestamp="$(echo $line | cut -d" " -f1)"
		echo $tempo_inicial

		if [ $tempo_inicial = "1" ]
		then
			tempo_inicial=$timestamp
		fi

		esp_ack="$(echo $line | cut -d" " -f9 | cut -d: -f2)"

		for ((j=i+1; j<$len; j++))
		do
			line2="$(sed $j'!d' $arq)"
			#echo "line2: $line2"
			param2="$(echo $line2 | cut -d" " -f7)"
			#echo "param2: $param2"

			if [ $param2 = '[P.],' ]
			then
				act_ack="$(echo $line2 | cut -d" " -f11)"

				if [ $esp_ack = $act_ack ] 
				then
					echo "OK"
					echo $line
					echo $line2
					echo ""
					break
				fi
			fi
		done
	fi
done

nano_tempo_inicial="$(date -u -d "$tempo_inicial" +"%s.%N")"
nano_tempo_final="$(date -u -d "$timestamp" +"%s.%N")"

echo $nano_tempo_inicial
echo $nano_tempo_final

date -u -d "0 $nano_tempo_final sec - $nano_tempo_inicial sec" +"%H:%M:%S.%N"


exit 0
