#!/usr/bin/bash

## /etc/hosts 에 서버IP	호스트명 추가

# Server Password
PASSWORD="$(/usr/bin/cat .secret.env | awk -F'=' '{print $2}')"

# PeaceMaker 모니터링 대상 서버 정보 저장
hosts="nfs"

for host in ${hosts}
do
	/usr/bin/echo "#### HOST:: ${host} ####"

	# PeaceMaker 상태 체크
	# grep -c : 매칭되는 단어의 갯수추출
	chk_cluster=$(/usr/bin/ssh -q ${host}@${host} sudo -S pcs status <<< ${PASSWORD} | /usr/bin/grep -i -c "failed") && /usr/bin/clear
	
	# PaceMaker 상태 체크가 양호하면 문제가 없는 것으로 인식
	if [[ ${chk_cluster} ]]
	then
		/usr/bin/echo "PaceMaker status is normal"
	# PaceMaker 상태 체크에 이상이 있으면 Pacemaker 상태 출력
	else
		/usr/bin/echo "Plase check pacemaker status"
		echo "*************************************"
		echo "$(ssh -q ${host}@${host} sudo -S pcs status <<< ${PASSWORD})"
	fi
done
