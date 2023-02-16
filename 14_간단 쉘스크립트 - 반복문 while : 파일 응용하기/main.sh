#!/usr/bin/bash

# FILE PATH
FILE="serverlist.txt"

# Loop
while read IP
do
	echo -e "[${IP}] 에 접속 중 ...\n"
done < ${FILE}
