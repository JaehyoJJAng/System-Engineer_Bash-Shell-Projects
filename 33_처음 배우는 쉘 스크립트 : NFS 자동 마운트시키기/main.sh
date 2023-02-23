#!/usr/bin/bash

# NFS 서버 IP
SERVER_IP='192.168.121.12'

# 마운트 서버의 nfs 경로 지정
nfs_server="${SERVER_IP}:/nfsshare"

# 마운트 할 디렉토리 지정
nfs_dir='/nfs-web'

# 마운트할 디렉토리가 있는지 체크 후 없으면, 디렉토리 생성
if [[ ! -d ${nfs_dir} ]]
then
	echo -e "Creating ${nfs_dir} ...\n"
	sudo /usr/bin/mkdir -p "${nfs_dir}" && echo -e "Completed!\n"
fi

# 해당 NFS와 디렉토리 마운트
sudo /usr/bin/mount -t nfs ${nfs_server} ${nfs_dir}

# 마운트 정보에서 마운트 타입과 옵션 추출
nfs_type="$(/usr/bin/mount | grep ${nfs_dir} | awk '{print $5}')"
nfs_opt="$(/usr/bin/mount  | grep ${nfs_dir} | awk '{print $6}' | awk -F',' '{print $1}'),sync,sec=sys"

# 1번째 인자부터 끝까지 출력
# /usr/bin/echo ${nfs_opt:1} 

# /etc/fstab 권한 설정
sudo /usr/bin/chmod o+w /etc/fstab

# 추출한 마운트 정보를 조합하여 /etc/fstab 에 설정하기
fstab_config="${nfs_server} ${nfs_dir} ${nfs_type} ${nfs_opt:1} 0 0" 
sudo /usr/bin/echo "${fstab_config}" >> /etc/fstab

# 설정한 /etc/fstab 내용 확인
/usr/bin/cat /etc/fstab | grep "${nfs_dir}"

# 마운트된 디렉토리 정보 확인
/usr/bin/df -h "${nfs_dir}"

# 마운트 해제
sudo /usr/bin/umount "${nfs_dir}"
