#!/usr/bin/bash

# 사용자 계정 및 패스워드가 입력 되었는지 확인
if [[ -n ${1} ]] && [[ -n ${2} ]]
then	
	# 배열 선언
	declare -a UserList
	declare -a Password

	UserList=(${1})
	Password=(${2})
	
	# for문을 이용하여 사용자 계정 생성
	## i = 0 : 변수 'i' 에 초기값 선언
	## i < ${#UserList[@]} : UserList 배열의 인수 갯수가 i 보다 작을때까지
	## i++ : i 증감
	for (( i=0; i < ${#UserList[@]}; i++ ))
	do
		# if문을 사용하여 사용자 계정이 있는지 확인
		if [[ $(cat /etc/passwd | grep "${UserList[${i}]}" | wc -l ) == 0 ]]
		then
			# 사용자 생성 및 패스워드 설정
			/usr/sbin/useradd ${UserList[${i}]}
			echo "${Password[${i}]}" | passwd ${UserList[${i}]} --stdin
		else
			# 사용자가 있다고 메시지를 출력
			echo "This User ${UserList[${i}]} is existing"
		fi
	done

	# 사용자 계정이 입력 되지 않은 경우
else
	echo -e "Please Input user_id and password.\nUsage : adduser-script.sh "user01 user02" "pw01 pw02""
fi
