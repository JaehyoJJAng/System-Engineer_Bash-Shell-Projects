#!/usr/bin/bash


# MySQLDump
mysqldump=$(which mysqldump)

# Set Host
HOST="$(/usr/bin/echo ${HOSTNAME} | awk -F'-' '{print $1}')" 

# Telegram File
TEL_FILE="$(/usr/bin/pwd)/telegram.sh"

# Date
DATE="$(/usr/bin/date +'%Y.%m.%d')"

# DB 백업경로 지정
DB_BACK_PATH="/mnt/mysql/${HOST}/${DATE}/db"

# 압축할 백업파일이름
DB_BACK_FILE_NM="${DB_BACK_PATH}/DB.tgz"

# 백업할 config 파일 지정
CONF_TARGET_PATH="/etc/mysql/"

# CONFIG 백업경로 지정
CONF_BACK_PATH="/mnt/mysql/${HOST}/${DATE}/config"

# CONFIG 파일명 지정
CONF_BACK_FILE_NM="${CONF_BACK_PATH}/CONFIG.tgz"

# LOG 파일명 지정
LOG_FILE_NM="/tmp/db-backup.log"

# 스토리지(NFS) 서버에 마운트
sudo /usr/bin/mount /mnt

# DB 백업경로 생성 (없는경우 , 있으면 패스)
if [[ ! -e ${DB_BACK_PATH} ]]
then
	sudo /usr/bin/mkdir -p "${DB_BACK_PATH}"
fi

# config 백업경로 생성 (없는경우 , 있으면 패스)
if [[ ! -e ${CONF_BACK_PATH} ]]
then
	sudo /usr/bin/mkdir -p "${CONF_BACK_PATH}"
fi


# Block 지정
{
	# 백업 시작시간 출력
	/usr/bin/echo "=== DB 백업 시작 ==="
	/usr/bin/date
	/usr/bin/echo 

	# DB 서버 데이터베이스 현재 경로에 백업하기 (./backup.sql)
	"${mysqldump}" -u db -p --password=db --all-databases --default-character-set=euckr > ./backup.sql 2>/dev/null

	# 백업된 DB 파일 압축하기
	sudo /usr/bin/tar -czpPf "${DB_BACK_FILE_NM}" ./backup.sql

	# ./backup.sql 삭제하기
	/usr/bin/rm -rf ./backup.sql

	# config 파일 백업하기
	sudo /usr/bin/tar -czpPf "${CONF_BACK_FILE_NM}" "${CONF_TARGET_PATH}"

	# DB NAME , SIZE 추출
	DB_NAME="$(/usr/bin/ls -lh ${DB_BACK_FILE_NM} | awk '{print $9}')"
	DB_SIZE="$(/usr/bin/ls -lh ${DB_BACK_FILE_NM} | awk '{print $5}')"

	# DB 정보 출력
	/usr/bin/echo "=== DB 정보 ==="
	/usr/bin/echo " | DB 파일명 : ${DB_NAME}"
	/usr/bin/echo " | DB 사이즈 : ${DB_SIZE}"
	/usr/bin/echo

	# CONFIG NAME , SIZE 추출
	CONF_NAME="$(/usr/bin/ls -lh ${CONF_BACK_FILE_NM} | awk '{print $9}')"
	CONF_SIZE="$(/usr/bin/ls -lh ${CONF_BACK_FILE_NM} | awk '{print $5}')"

	# CONFIG 정보 출력
	/usr/bin/echo "=== CONFIG 정보 ==="
	/usr/bin/echo " | CONFIG 파일명 : ${CONF_NAME}"
	/usr/bin/echo " | CONFIG 사이즈 : ${CONF_SIZE}"
	/usr/bin/echo

	# 백업 종료시간 출력
	/usr/bin/echo "=== DB 백업 종료 ==="
	/usr/bin/date
	/usr/bin/echo
} >| "${LOG_FILE_NM}"

# 텔레그램 알림 보내기
"${TEL_FILE}" "${HOST}" "$(/usr/bin/cat ${LOG_FILE_NM})" && /usr/bin/clear; echo "Telegram Alarm Success!"

# 로그파일 삭제
sudo /usr/bin/rm -rf "${LOG_FILE_NM}"

# 마운트 해제
sudo /usr/bin/umount /mnt
