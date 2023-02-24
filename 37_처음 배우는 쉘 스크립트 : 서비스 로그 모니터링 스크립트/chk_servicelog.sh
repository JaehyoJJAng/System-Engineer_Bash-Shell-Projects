#!/usr/bin/bash


# 모니터링 대상 서버 정보
hosts='db nfs'

# 모니터링 대상 서비스 정보 저장
services='mysql pacemaker'

# 서버 패스워드
PASSWORD="$(/usr/bin/cat .secret.env | grep 'password' | awk -F'=' '{print $2}')"

for host in ${hosts}
do
	echo "#### HOST:: ${host} ####"
	
	for service in ${services}
	do
		if [[ ${host} == 'nfs' ]] && [[ ${service} == 'pacemaker' ]]
		then
			/usr/bin/echo -e "${host} : ${service}\n"
			# pacemaker's error log 검색
			chk_log="$(/usr/bin/ssh ${host}@${host} sudo -S tail -n 30 /var/log/${service}/${service}.log <<< ${PASSWORD} | grep -i 'error:.*' | wc -l)"

			# error log 가 없으면 메시지를 보여줌
			if [[ ${chk_log} -eq 0 ]]
			then
				/usr/bin/echo "No error services logs. The ${service} is normal"
			else
				/usr/bin/echo "Please check service ${service} logs and service ${service}"
				echo "$(/usr/bin/ssh ${host}@${host} sudo -S tail -n 30 /var/log/${service}/${service}.log <<< ${PASSWORD} | grep -i 'error:.*')"
			fi
		elif [[ ${host} == 'db' ]] && [[ ${service} == 'mysql' ]]
		then
			/usr/bin/echo -e "${host} : ${service}\n"
			# mysql's error log 검색
			chk_log="$(/usr/bin/ssh ${host}@${host} sudo -S tail -n 30 /var/log/${service}/error.log <<< ${PASSWORD} | grep -i 'error' | wc -l)"

			# error log 가 없으면 메시지를 보여줌
			if [[ ${chk_log} -eq 0 ]]
			then
				/usr/bin/echo "No error services logs. The ${service} is normal"
			else

				/usr/bin/echo "Please check service ${service} logs and service ${service}"
				echo "$(/usr/bin/ssh ${host}@${host} sudo -S tail -n 30 /var/log/${service}/error.log <<< ${PASSWORD} | grep -i 'error')"
			fi
		fi
	done
	echo ""
done

