> awk

: sed기능 + 변수/함수/연산자를 사용하여 필요한 데이터를 제어할 수 있는 커맨드

| 옵션 | 설명
| :--: | :--: 
| -F 필드구분자 | 필드를 구분하기 위한 구분자를 지정
| -f 파일이름 | awk 프로그램이 읽어들일 파일 이름을 지정
| -변수=변수값 | awk 프로그램에서 사용할 변수를 지정

***

### 첫 번째 필드의 row 출력

```
$ awk '{print $1}' ./txt
```

### 두 번째 필드의 row 출력

```
$ awk '{print $2}' ./txt
```

### awk 검색기능 : 끝 문자가 'c'로 끝나는 스트링 출력하기

```
# grep 응용
$ awk '{print $1}' txt | grep "c$"

ccc
```

```
# awk만 사용
$ awk '/ccc/ {print $1}' txt 

ccc
```

### awk 검색기능 : 111 문자열이 있는 필드에서 3번째 필드의 첫번째 로우 값 출력해보기

```
# grep 응용
$ grep '111' ./txt | awk '{print $3}'

zzz
```

```
# awk만 사용
$ awk '/111/ {print $3}' ./txt

zzz
```

### 구분자 옵션으로 필드 구분하기

```
$ awk -F':' '{print $1}' colon_txt
```

```
$ awk -F':' '{print $1}' /etc/passwd
```

```
# Load Average 수치만 추출하기
$ uptime | awk -F'load average:' '{print $2}' | awk -F',' '{print $1 $2 $3}'

0.04 0.06 0.07
```

