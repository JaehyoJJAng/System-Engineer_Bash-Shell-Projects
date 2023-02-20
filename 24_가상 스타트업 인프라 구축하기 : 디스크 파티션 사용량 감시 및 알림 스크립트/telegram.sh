#!/usr/bin/bash

#############################################################################
## 2개의 Parameter 필요
## 1. 서버 호스트이름
## 2. 메세지
## 실행 결과는 현재 날짜/시각 , 서버이름 , 지정한 메시지를 텔레그램으로 보내도록 함
#############################################################################


# Parameter 체크
if [[ ${#} -ne 3 ]]
then
	# Console Clear
	/usr/bin/clear
	
	# Print
	echo "====================================================="
	echo -e "Script Usage ⬇️ \n${0} <HOSTNAME} <MESSAGE>"
	echo "====================================================="

	exit 1
fi

### 텔레그램 봇 관련 정보
##
BOT_INFOS=($(cat .secrets | awk -F'=' '{print $2}'))

# TOKEN
TOKEN=${BOT_INFOS[0]}

# CHAT ID
CHAT_ID=${BOT_INFOS[1]}
##
###

# URL
URL="https://api.telegram.org/bot${TOKEN}/sendMessage"

# 날짜
DATE="$(date +'%Y-%m-%d %H:%M')"

# 보낼 메시지 작성
TEXT="${DATE} 
[${1}] Server 알림
${2} : ${3}"

## 메시지 보내기
# 출력 결과는 필요 없기에 /dev/null 로 보냄
/usr/bin/curl -s -d "chat_id=${CHAT_ID}&text=${TEXT}" ${URL} > /dev/null
