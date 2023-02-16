#!/usr/bin/bash

# Set Hosts
HOSTS=('cent1' 'cent2' 'cent3')

# Loop #1
for SVG in ${HOSTS[@]}
do
    echo "[${SVG}]에 접속합니다 ..."
    /usr/bin/ssh ${SVG} "uptime"
done