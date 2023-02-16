#!/usr/bin/bash

# Set Hosts
HOSTS=('cent1' 'cent2' 'cent3' 'cent4' 'cent5')

# array 전체 출력
echo ${HOSTS[@]}

# array 첫번째 요소  출력
echo ${HOSTS[0]}

# array 갯수 출력
echo ${!HOSTS[@]}

# ======= ! 쉘 스크립트에서 배열은 자주 사용되지 않음 ========
# 배열 대신 파일 사용을 권장 

# for 문으로 array 각 요소 뽑아오기 #1
for NUM in ${!HOSTS[@]}
do
	echo ${HOSTS[${NUM}]}
done

# for 문으로 array 각 요소 뽑아오기 #2
for HOST in ${HOSTS[@]}
do
	echo ${HOST}
done
