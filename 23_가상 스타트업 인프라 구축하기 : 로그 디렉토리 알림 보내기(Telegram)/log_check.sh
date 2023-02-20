#!/usr/bin/bash


# 검사할 디렉토리 지정
DIR='/var/log/nginx'

# 1. 로그 디렉토리의 크기 확인
SIZE="$(du -m ${DIR} | awk '{print $1}')"

# HostName
HOST="${HOSTNAME}"

# Telegram File Path
TEL_FILE="$(pwd)/telegram.sh"

# 2. 크기가 1기가(1024M) 이상일 경우 관리자에게 알림
if [[ "${SIZE}" -ge 1 ]] # 테스트 용으로 값을 1로 설정
then
	TEXT="${DIR} 사용량이 ${SIZE}M 가 넘었습니다"
	"${TEL_FILE}" "${HOST}" "${TEXT}"
fi
