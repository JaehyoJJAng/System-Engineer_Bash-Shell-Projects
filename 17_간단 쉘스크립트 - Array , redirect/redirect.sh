#!/usr/bin/bash


# == 리다이렉트 예제 #1 ==
# while 반복문으로 파일 내용 읽어오기
# Set FILE
FILE='serverlist.txt'

# While Loop
while read IP
do
	echo ${IP}
done < ${FILE}


# == 리다이렉트 예제 #2 ==
# 표준출력과 표준에러 출력 결과를 파일로 생성하기
# Set FILE
ls_result='ls.log'
ls_error='ls-error.log'

# Target File
FILE='idontknow'

# Create Log
/usr/bin/ls -alh ${FILE} 1>${ls_result} 2>${ls_error}


# == 리다이렉트 예제 #3 ==
# exec 리다이렉트 기호 사용방법
# report 파일 생성
/usr/bin/touch report

# report 파일 초기화
/usr/bin/cp -f /dev/null report

# Set redirect 
exec 3>> ./report

# df result
/usr/bin/df -h >&3

# free result
/usr/bin/free -m >&3

# uptime result
/usr/bin/uptime >&3
