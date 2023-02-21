#!/usr/bin/bash

# Set Variable
OS_TYPE='Redhat Ubuntu Fedora Debian'

# 문자열 슬라이싱 (Redhat 만 출력하기)
OS="${OS_TYPE:0:6}" 

# 문자열 슬라이싱 (Redhat 만 제외하기)
OS="${OS_TYPE:6}"

echo ${OS}
