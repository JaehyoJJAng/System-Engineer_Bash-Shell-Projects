#!/usr/bin/bash

# Mount
/usr/bin/mount | grep "overlay.*"

# nfs 서버의 /nfs 디렉토리를 내 로컬 /mnt 와 마운트
mount -t nfs 172.18.1.93:/nfs /mnt 
