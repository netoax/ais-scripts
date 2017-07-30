#!/bin/bash

tcpdump_num="$(ps aux | grep tcpdump | sed 1'!d' | cut -d" " -f7)"
sub_num="$(ps aux | grep mosquitto_sub | sed 1'!d' | cut -d" " -f7)"

echo "TCPDUMP = $tcpdump_num"
echo "SUB = $sub_num"

sudo kill $tcpdump_num
sudo kill $sub_num
