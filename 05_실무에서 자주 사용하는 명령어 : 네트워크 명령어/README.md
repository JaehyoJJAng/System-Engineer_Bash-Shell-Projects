> ifconfig

: 네트워크 인터페이스 활성/비활성화 설정

> ip

: ip 관련 정보 조회 및 설정

```
$ ip ad sh | grep "inet*" | head -n 5

inet 127.0.0.1/8 scope host lo
inet6 ::1/128 scope host
inet 10.178.0.3/32 brd 10.178.0.3 scope global dynamic ens4
inet6 fe80::4001:aff:feb2:3/64 scope link
inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
```

> netstat

- 서비스별 포트는 /etc/services 에서 확인 가능

- -n : 포트 번호로 출력
- -l : 리스닝 소켓 출력
- -t : TCP 통신 출력
- -p : PROGRAM name
- -u : UDP 통신 출력
- -a : 현재 네트워크 상태 전체 출력

: 네트워크 프로토콜의 통계와 연결상태 출력

```
$ netstat -nltpu | grep "80"

tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      -
tcp6       0      0 :::80                   :::*                    LISTEN      -
```

> ss (socket statistics)

: 네트워크 소켓 통계와 연결상태 출력

```
$ ss -nltpu

tcp   LISTEN 0      4096         0.0.0.0:80         0.0.0.0:*
tcp   LISTEN 0      4096            [::]:80            [::]:*
```


> iptables

: 패킷 필터링 도구로 패킷의 출입을 제한하는 방화벽구성이나 NAT 구성에 사용

```
$ iptables -nL
```

> ufw

: iptables의 제어를 쉽게 하기 위한 도구

> ping

: ICMP 프로토콜의 응답 확인 도구

```
$ ping -c 3 8.8.8.8 

64 bytes from 8.8.8.8: icmp_seq=1 ttl=122 time=1.18 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=122 time=0.658 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=122 time=0.670 ms
```

> wget (World Wide Web + Get)

: 웹서버로부터 컨텐츠를 가져오는 도구

> curl (Client for URLs)

- -L : 리다이렉트 링크를 따라가는 옵션
- -k : https 의 인증 무시
- -s : 사일런트 모드로 실행 (통계값 출력 무시)
- -o : 아웃풋 파일 지정 (-o /dev/null) - 아웃풋을 /dev/null(휴지통) 로 보냄 
- -w : 아웃풋 포맷 지정 "%{http_code}\n" : http status code 만 출력

```
$ curl -Lkso /dev/null -w "%{http_code}\n" https://gmail.com
```

: 다양한 프로토콜을 사용하여 데이터를 전송하게 해 주는 도구


