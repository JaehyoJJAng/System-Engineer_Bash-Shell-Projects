#!/usr/bin/bash

# File Name
FILE_NAME="./serverlist.txt"

# Loop
for X in $(seq 1 50)
do
	echo "192.168.1.${X}" >> ${FILE_NAME}
	echo -e "Add IP address successfully [192.168.1.${X}]\n"
done
