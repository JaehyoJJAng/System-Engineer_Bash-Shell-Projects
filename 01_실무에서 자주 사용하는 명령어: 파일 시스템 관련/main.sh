#!/usr/bin/bash

# ls
# /usr/bin/ls -alh
# /usr/bin/ls -alt
# /usr/bin/ls -alhr | head -n 3 

# df
# /usr/bin/df -h
# /usr/bin/df -hTi
DISK_USAGE=($(/usr/bin/df | awk '{print $4}' | grep -v "[A-Z]"))
# IFS=' '
for USAGE in ${DISK_USAGE[@]}
do
    if [[ ${USAGE} > 5120 ]]
then
    echo ${USAGE}
fi
done