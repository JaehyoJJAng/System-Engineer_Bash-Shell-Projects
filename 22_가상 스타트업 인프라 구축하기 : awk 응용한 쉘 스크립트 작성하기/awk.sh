#!/usr/bin/bash

function check_argument {
# Percent가 100 보다 큰 경우
if [[ "${PER}" -gt 100 ]]
then
	echo -e "Percent 는 100% 을 넘을 수 없습니다 [${PER}]\n"
	exit 1
fi

# Percent가 0 보다 작은 경우
if [[ "${PER}" -lt 0 ]]
then
	echo -e "Percent 는 0 보다 작을 수 없습니다 [${PER}]\n"
	exit 1
fi

}

function awk_shell {
	# Array 선언
	declare -a MOUNTS
	declare -a USAGES

	MOUNTS=($(df -h | awk '{print $6}' | grep -v "[A-Z]"))
	USAGES=($(df -h | awk '{gsub(/%/,""); print $5 }' | grep -v "[A-Z]"))

	for IDX in ${!MOUNTS[@]}
	do
		USAGE=${USAGES[${IDX}]}
		if [[ ${USAGE} -ge ${PER} ]]
		then
			MOUNT=${MOUNTS[${IDX}]}
			echo -e "${USAGE}%\t${MOUNT}"
		fi
	done
}

# PER
PER="${1}"

# Arguemnt 없는 경우
if [[ ${#} -ne 1 ]]
then
	echo "No Argument!"
	exit 1
fi

# Check Argument
check_argument

# Get Disk Usage & Mount
awk_shell 
