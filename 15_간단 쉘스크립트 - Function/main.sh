#!/usr/bin/bash

# Set Function
function desc {
	echo "나는 ${1} 입니다"
}

# Set Indent
function indent {
	echo "===================="
	echo ${1}
	echo "===================="
}
# 함수 호출
desc '이재효'

# 함수 호출
indent 'df 결과 입니다'
