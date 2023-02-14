> redirection

: 표준 스트림(stdin,stdout,stderr) 을 부등호를 사용하여 지정한 위치로 보낼 수 있는 방향지정 옵션

```
# 스트링 'y'를 입력값으로 전달
$ docker system prune -a --volumes <<< y 

$ echo "Hello" 1> say_hello.txt 2>/dev/null

$ echo "Bye" 1>> say_hello.txt 2>/dev/null

# 강제적으로 파일을 문제없이 생성하는 리다이렉션 기능
# echo "kkk" >| say_hello.txt
```

> chmod

: 파일 / 디렉토리 모드(접근권한) 변경 도구

```
# 유저/그룹/게스트 에게 실행권한 부여
$ chmod +x ./main.sh

# 유저/그룹/게스트 로부터 실행권한 삭제
$ chmod -x ./main.sh

# 유저에게 실행권한 부여
$ chmod u+x ./main.sh

# 그룹에게 실행권한 부여
$ chmod g+x ./main.sh

# 게스트에게 실행권한 부여
$ chmod o+x ./main.sh
```

> chown

: 파일 소유권 변경

```
# 하위 디렉토리들의 소유권까지 변경
chown -R jaehyo:jaehyo myweb/
```