#!/usr/bin/bash

# FILENAME
FILE_NAME="serverlist.txt"

# Loop
for IP in $(cat ${FILE_NAME})
do
	echo  "[${IP}] 에 접속 중 ..."
	echo -e "-- 명령어 실행 구간 --\n"
done
