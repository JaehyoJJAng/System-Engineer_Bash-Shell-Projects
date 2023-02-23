#!/usr/bin/bash

# 모니터링 대상 서버 정보
hosts='nfs'

# 서버 패스워드
PASSWORD="$(/usr/bin/grep 'password' .secret.env | awk -F'=' '{print $2}')"

for host in ${hosts}
do
	/usr/bin/echo "#### HOST:: ${host} ####"

	# MEM 사용률 체크
	chk_mem="$(/usr/bin/free -h | grep "Mem" | awk '{print $4}')"

	# 메모리 결과
	/usr/bin/echo "Memory free size is ${chk_mem}"
done
