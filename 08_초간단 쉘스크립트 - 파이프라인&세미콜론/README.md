## 한줄 스크립트

> 파이프라인 ( | )

- testfile.txt 안에 777 이라는 문자열이 있는지 확인

```
$ cat testfile.txt | grep "777" && echo "777 exists"
$ echo ${?} # 0
```

> 세미콜론 ( ; )

- a 서버에서 b서버의 루트 파티션의 용량 살펴보기

```
$ ssh user-01@172.16.1.1; df -h | grep "/dev/sda1*"

$ ssh user-01@172.16.1.1 "df -h | grep "/dev/sda1*"
```

> AND 조건 ( && )

- AND 좌측 명령/테스트의 결과가 참이면 우측의 명령을 실행
- AND 좌측 명령/테스트의 결과가 거짓이면 우측의 명령을 실행하지 않음
```
$ true && echo "Success"
$ false && echo "Fail"
```

> OR 조건 ( || )

- OR 좌측 명령/테스트의 결과가 참이면 우측의 명령 실행하지 않음
- OR 좌측 명령/테스트의 결과가 거짓이면 우측의 명령을 실행

```
$ true || echo "Fail"
$ false || echo "Success"
```