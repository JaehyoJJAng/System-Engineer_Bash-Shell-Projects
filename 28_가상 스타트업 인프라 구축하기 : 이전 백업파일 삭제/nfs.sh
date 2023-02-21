#!/usr/bin/bash

# Set HOST
HOST=$(echo ${HOSTNAME} | awk -F'-' '{print $1}')

# Telegram File Path
TEL_FILE="$(/usr/bin/pwd)/telegram.sh"

# Date
DATE=$(date +'%Y.%m.%d')

# 로그파일 지정
LOG_FILE_NM="/tmp/nfs-backup.log"

# 백업 리스트
BACK_LIST="/etc/exports /etc/fstab"

# 백업 디렉토리
BACK_PATH="/mnt/backup/${HOST}"

# 백업 디렉토리 생성 (없는 경우, 있으면 패스)
if [[ ! -e ${BACK_PATH} ]]
then
	sudo /usr/bin/mkdir -p "${BACK_PATH}"
fi

# 백업 파일명
BACK_FILE_NM="${BACK_PATH}/${DATE}.tgz"

# 스토리지(NFS) 서버의 /nfsshare 공유디렉토리를 /mnt 에 마운트
sudo /usr/bin/mount /mnt

# 로그 기록하기
{
	# 백업시작 시간 출력
	/usr/bin/echo "=== 백업시작 ==="
	/usr/bin/date +'%Y.%m.%d %H:%M'
	/usr/bin/echo

	# nfs 설정파일 백업하기
	sudo /usr/bin/tar -czpPf "${BACK_FILE_NM}" ${BACK_LIST}
	
	# 알림보낼 백업파일 이름 추출
	ALARM_NAME="$(/usr/bin/ls -lh ${BACK_FILE_NM} | awk '{print $9}')"

	# 알림보낼 백업파일 사이즈 추출
	ALARM_SIZE="$(/usr/bin/ls -lh ${BACK_FILE_NM} | awk '{print $5}')"

	# 백업파일 정보 출력
	/usr/bin/echo "++++ 백업파일 정보 ++++"
	/usr/bin/echo " | 파일명 : ${ALARM_NAME}"
	/usr/bin/echo " | 사이즈 : ${ALARM_SIZE} Bytes"
	
	# 이전 백업 파일 삭제
	/usr/bin/echo
	/usr/bin/echo "=== 이전 파일 삭제 ==="
	/usr/bin/find -mtime +7 -exec sh -c "ls -l {}; rm -rf {}" \; 2>/dev/null
	/usr/bin/echo 

	# 백업종료 시간 출력
	/usr/bin/echo "=== 백업종료 ==="
	/usr/bin/date +'%Y.%m.%d %H:%M'
	/usr/bin/echo
} >| "${LOG_FILE_NM}"

# 텔레그램으로 백업 로그 전송하기
"${TEL_FILE}" "${HOST}" "$(/usr/bin/cat ${LOG_FILE_NM})" && /usr/bin/clear; echo "Telegram Alarm Success!" 

# 로그파일 삭제
sudo /usr/bin/rm -rf "${LOG_FILE_NM}"

# 스토리지 언마운트
sudo /usr/bin/umount /mnt
