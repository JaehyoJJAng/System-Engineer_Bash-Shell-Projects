#!/usr/bin/bash

function plus {
	echo "${1} + ${2} = $(( ${1} + ${2} ))"
	echo
}

function minus {
	echo "${1} - ${2} = $(( ${1} - ${2} ))"
	echo
}

function division {
	if [[ ${2} == 0 ]]
	then
		echo "0으로는 나눌수 없습니다"
		exit 1
	fi
	echo "${1} / ${2} = $(( ${1} / ${2} ))"
	echo
}
