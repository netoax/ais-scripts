#!/bin/bash

arq="log3.txt"

len="$(wc $arq | cut -d" " -f3)"

echo "O arquivo possui $len linhas"

tempo_inicial=""
tempo_final=""
timestamp=0
esp_ack=""
num_send_packet=0
i=0

for ((i=1; i<$len; i++))
do
	line="$(sed $i'!d' $arq)"
	param="$(echo $line | cut -d" " -f7)"

	if [ $param = '[P.],' ]
	then
		tempo_inicial="$(echo $line | cut -d" " -f1)"
		num_send_packet=$((num_send_packet + 1))

		# echo "Achei [P.] nº $num_send_packet na linha $i"

		for ((j=i+1; j<$len; j++))
		do

			line2="$(sed $j'!d' $arq)"
			param2="$(echo $line2 | cut -d" " -f7)"

			if [ $param2 = '[FP.],' ]
			then

				# echo "Achei [FP.] nº $num_send_packet na linha $j"

				tempo_final="$(echo $line2 | cut -d" " -f1)"

				nano_tempo_inicial="$(date -u -d "$tempo_inicial" +"%s.%N")"
                nano_tempo_final="$(date -u -d "$tempo_final" +"%s.%N")"
				diff="$(date -u -d "0 $nano_tempo_final sec - $nano_tempo_inicial sec" +"%s.%N")"
				timestamp="$(date -u -d "0 $timestamp sec + $diff sec" +"%s.%N")"

				tempo_inicial=""
                tempo_final=""

				i=j
		
				break

			fi

		done

	fi

done

div="$(bc <<< "scale=9; $timestamp/$num_send_packet")"

date -u -d "0 $div sec" +"%H:%M:%S.%N"

exit 0
