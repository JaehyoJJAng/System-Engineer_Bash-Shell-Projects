#!/usr/bin/bash

# 운영체제 타입 확인
os_type="$(/usr/bin/cat /etc/*release | grep "ID_LIKE" | awk -F'=' '{print $2}')"

# 네트워크 정보를 사용자로부터 입력 받음
/usr/bin/echo "==== Network Devices ===="
/usr/sbin/ip ad sh | grep '^[0-9]' | awk '{print $1" "$2}' | grep -v -e 'lo' -e 'v' -e 't'
echo ""
read -p "Please input network interface: " net_name
read -p "Please input network ip: " net_ip 
read -p "Please input network gateway: " net_gw 
read -p "Please input network dns: " net_dns

# 하나라도 입력하지 않았을 경우 입력하라는 메시지 출력 후 , 스크립트 종료
if [[ -z "${net_name}" ]] || [[ -z "${net_ip}" ]] || [[ -z "${net_gw}" ]] || [[ -z "${net_dns}" ]]
then
	/usr/bin/echo "You need to input network information. Please retry this script"
	exit 1
fi

# 운영체제가 데비안 인지 체크
if [[ ${os_type} == 'debian' ]]
then
	# 설정하고자 하는 인터페이스가  netplan/*.yaml 에 있는지 체크
	ip_chk=$(/usr/bin/grep "${net_name}" /etc/netplan/*.yaml | wc -l)
	
	# 설정하려는 인터페이스가 *.yaml 파일에 없는경우
	if [[ ${ip_chk} -eq 0 ]]
	then
		/usr/bin/cat > /etc/netplan/${net_name}.yaml << EOF
network:
  ethernets:
    ${net_name}:
      addresses:
        - ${net_ip}/24
      gateway4:${net_gw} 
      nameservers:
        addresses:
          - ${net_nds} 
  version: 2
  renderer: NetworkManager
EOF	
		/usr/bin/echo "cat /etc/netplan/${net_name}.yaml"
		/usr/bin/echo "Apply netplan"
		/usr/sbin/netplan apply
	else
		/usr/bin/echo "This ${net_name} is configured already."
	fi

else
	/usr/bin/echo "OS TYPE을 확인할 수 없었습니다"
	exit 1	
fi
