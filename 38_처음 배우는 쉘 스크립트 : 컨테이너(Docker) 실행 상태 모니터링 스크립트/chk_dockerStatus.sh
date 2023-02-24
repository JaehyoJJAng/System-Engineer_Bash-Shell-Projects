#!/usr/bin/bash

# 모니터링 서버
hosts="db nfs"

for host in ${hosts}
do
	/usr/bin/echo "#### HOST :: ${host} ####"

	# 해당 호스트에 도커가 설치되어 있는지 확인
	chk_docker="$(/usr/bin/ssh -q ${host}@${host} rpm -qa | grep -c docker)"
	
	if [[ ${chk_docker} > 0 ]]
	then
		echo "This System's container engine is docker"

		# docker 서비스가 실행 중인지 확인
		chk_service=$(/usr/bin/ssh -q ${host}@${host} systemctl is-active docker)

		if [[ ${chk_service} == 'active' ]]
		then
			/usr/bin/echo "Docker running state is active"

			# container 프로세스 확인
			chk_container=$(/usr/bin/ssh -q ${host}@${host} docker ps | grep -c 'seconds')
			if [[ ${chk_container} > 0 ]]
			then
				echo "Please check your container state"
				echo "$(/usr/bin/ssh -q ${host}@${host} docker ps | grep 'seconds')"
			else
				echo "Container status is normal"
			fi
		else
			echo " Please check your docker state"
		fi
	fi
done
