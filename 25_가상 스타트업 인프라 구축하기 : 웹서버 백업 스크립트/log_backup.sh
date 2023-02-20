#!/usr/bin/bash

# Set HostName
HOST="$(echo ${HOSTNAME} | awk -F'-' '{print $1}')"

# 기록할 LOG FILE 이름지정
LOG_FILE_NM="/tmp/backup.log"

# 텔레그램 파일 경로
TEL_FILE="$(/usr/bin/pwd)/telegram.sh"

# 날짜
DATE="$(/usr/bin/date +%Y.%m.%d)"

# 백업할 디렉토리/파일 지정
BACKUP_LIST='/etc/nginx /usr/share/nginx/html'

# 백업 디렉토리 지정
BACK_PATH="/mnt/backup/${HOST}"

# 백업 파일명 지정
BACK_FILE_NM="${BACK_PATH}/${DATE}.tgz"

# 백업 디렉토리 생성 (없는 경우 , 있으면 Pass)
if [[ ! -e ${BACK_PATH} ]] # -e : exists
then
	echo "===================================="
	/usr/bin/echo "백업 디렉토리를 생성합니다"
	sudo /usr/bin/mkdir -p "${BACK_PATH}"
	echo "===================================="
fi

## NFS 서버에 마운트 (nfs)
# /etc/fstab 에 192.168.121.12:/nfsshare 가 등록 되어있어야함
sudo /usr/bin/mount /mnt

########### 로그 기록 시작 ################
# {} 안에 기록할 로그 작성
{
	# 백업 시작 시간 출력
	/usr/bin/echo -e "\n=== 백업시작 시각 : $(date '+%Y.%m.%d %H:%M') ===\n"

	# 백업
	# -p : 퍼미션 유지
	# -P : 절대경로 유지
	sudo /usr/bin/tar -czpPf "${BACK_FILE_NM}" ${BACKUP_LIST}

	# 알람보낼 파일이름 추출
	ALARM_NAME=$(/usr/bin/ls -lh "${BACK_FILE_NM}" | awk '{print $9}')

	# 알람보낼 파일사이즈 추출
	ALARM_SIZE=$(/usr/bin/ls -lh "${BACK_FILE_NM}" | awk '{print $5}')


	# 백업파일 정보 출력
	/usr/bin/echo -e "=== 백업 파일 정보 ==="
	/usr/bin/echo " | 파일명 : ${ALARM_NAME}"
	/usr/bin/echo " | 사이즈 : ${ALARM_SIZE}"
	/usr/bin/echo " ===		     ==="

	# 백업 종료시각 출력
	/usr/bin/echo "=== 백업 종료시각 : $(date +'%Y.%m.%d %H:%M') ==="
	/usr/bin/echo

# {} 스코프 내에서 출력된 표준출력 내용을 /tmp/backup.log 파일로 저장
} >| "${LOG_FILE_NM}"

# ++++++++++++++ 로그 기록 종료 ++++++++++++++++++++

## NFS 서버 언마운트
#
sudo /usr/bin/umount /mnt

## 텔레그램으로 백업로그 전송하기
#
"${TEL_FILE}" "${HOST}" "$(/usr/bin/cat ${LOG_FILE_NM})" && /usr/bin/clear; echo "Alarm Success!"

## 로그파일 삭제하기
/usr/bin/rm -rf "${LOG_FILE_NM}"
