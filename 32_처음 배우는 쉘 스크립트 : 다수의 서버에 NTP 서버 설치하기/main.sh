#!/usr/bin/bash

# NTP 를 설치할 대상 서버정보 저장
servers='db nfs'

# Server Port
PORT="${1}"

# Command
CMD1='cat /etc/*release | grep ID_LIKE | sed "s/ID_LIKE=//;s/\"//g"'
CMD2=''

for server in ${servers}
do
	# 해당 서버의 운영체제 타입 확인
	ostype=$(sshpass -p "${PORT}" ssh ${server} "${CMD1}"

	# 운영체제가 Fedora 계열인지 Debian 계열인지 확인
	if [[ ${ostype} == 'fedora' ]]
	then
		CMD2='sudo yum install -y ntp'
	elif [[ ${ostype} == 'debian' ]]
	then
		CMD2='sudo apt-get install -y ntp'
	fi

	# 해당 운영체제에 ntp 설치
	sshpass -p ${PORT} ${server} "${CMD2}"
done
