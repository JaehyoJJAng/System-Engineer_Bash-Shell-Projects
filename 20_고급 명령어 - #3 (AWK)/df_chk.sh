#!/usr/bin/bash


# MOUNTS
MOUNTS=($(df -h | awk '{print $6}' | grep -v "[A-Z]"))

# USAGES
USAGES=($(df -h | awk '{gsub(/%/,""); print $5}' | grep -v "[A-Z]"))

# Loop
for INDEX in ${!MOUNTS[@]}
do
	# USAGE
	USAGE=${USAGES[${INDEX}]}

	# USAGE가 20% 이상인 경우에만 알림
	if [[ ${USAGE} -ge 20 ]]
	then
		MOUNT=${MOUNTS[${INDEX}]}
		echo "'${MOUNT}' 디렉토리의 사용량이 ${USAGE}% 입니다."
	fi
done
