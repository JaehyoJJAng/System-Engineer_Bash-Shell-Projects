#!/usr/bin/bash

# Console Clear
/usr/bin/clear

# Check Argument
if [[ ${#} -ne 1 ]]
then
    echo "No Argument"
    exit 1
fi

# Set Check Usage
CHECK_USAGE="${1}"

# df Counts
DF_COUNT=$(( $(/usr/bin/df -h | /usr/bin/wc -l)  - 1))

# Get Mounts
MOUNTS=($(/usr/bin/df -h | /usr/bin/awk '{print $6}' | grep -v "[A-Z]"))

# Get Usages
USAGES=($(/usr/bin/df -h | /usr/bin/awk '{gsub(/%/,""); print $5}' | grep -v "[A-Z]"))

for INDEX in $(seq 0 ${DF_COUNT})
do 
    # Get Usage
    USAGE="${USAGES[${INDEX}]}"
    
    if [[ "${USAGE}" -ge ${CHECK_USAGE} ]]
    then
        # Get Mount
        MOUNT="${MOUNTS[${INDEX}]}"
        
        # Print
        echo "[${MOUNT}] : ${USAGE}%"
    fi
done 



