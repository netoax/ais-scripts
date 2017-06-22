#!bin/bash

arq="arq.txt"

len="$(wc $arq | cut -d" " -f3)"

tempo_inicial=""
esp_ack=""

for ((i=1; i<$len; i++))
do
	line="$(sed $i'!d' $arq)"
	param="$(cut -d" " -f7 $line)"

	if $param -eq '[P.]'
	then
		esp_ack="$(cut -d" " -f9 $line | cut -d: -f2)"

		for ((j=i+1; j<$len; j++))
		do
			line2="(sed $j'!d' $arq)"
			param2="$(cut -d" " -f7 $line2)"

			if $param2 -eq '[P.]'
			then
				act_ack="$(cut -d" " -f11 $line2)"

				if $esp_ack -eq $act_ack
				then
					echo "OK"
					break
				fi
			fi
		done
	fi
done

exit 0
