#!bin/bash

arq="arq.txt"

len="$(wc $arq | cut -d" " -f3)"

for ((i=1; i<$len; i++))
do
	line="$(sed $i'!d' $arq)"
	
	
	param="$(cut -d" " -f7 $line)"
	if $param -eq '[P.]'
	then
		echo ${line}
		esp_ack="$(cut -d" " -f9 $line | cut -d: -f2)"
	fi
done

exit 0
