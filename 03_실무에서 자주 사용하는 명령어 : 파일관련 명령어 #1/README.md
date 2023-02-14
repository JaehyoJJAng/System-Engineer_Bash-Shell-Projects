> touch

- 지정한 이름의 비어있는 파일을 생성하거나 파일이 있는 경우 타임스탬프 업데이트

```
$ touch new_file.txt
$ touch {new{1..5},old{1..5}}

$ ls -lt

-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 new1
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 new2
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 new3
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 new4
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 new5
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 old1
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 old2
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 old3
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 old4
-rw-r--r-- 1 wogy12395 wogy12395   0 Feb 14 14:58 old5
-rw-r--r-- 1 wogy12395 wogy12395 182 Feb 14 14:58 README.md
```

> cat

```
$ cat main.sh | head -n 10
$ cat main.sh | tail -n 10
```


> cp

-   -r(-R,--recursive) : 하위 디렉토리 포함
-   -f(--force) : 강제 덮어씌우기
-   -p : permission 그대로 승계


```
$ cp -rfp 원본파일패스/이름 복사할파일패스/이름

$ cp -R main.sh ./old-main.sh
```

> tail

```
$ tail -f /dev/null
$ tail -n 10
```

> ln

지정한 파일에 대한 심볼릭 링크나 하드링크 생성

- 대상이 되는 파일의 경로가 상대경로인 경우
상황에 따라서 심볼릭 링크가 깨질수 있음.

```
$ mkdir desktop && cd desktop
$ ln -s ../README.md ./읽어줘.md

lrwxrwxrwx 1 wogy12395 wogy12395 12 Feb 14 15:05 읽어줘.md -> ../README.md
```

> dd (Dataset Dafinition)

```
$ dd if=인풋파일이름 of=아웃풋파일이름 bs=바이트(크기) count=블럭을복사할횟수

# 10kbyte 짜리 파일 생성하기
$ dd if=/dev/urandom of=./ddtest bs=1024 count=10

10+0 records in
10+0 records out
10240 bytes (10 kB, 10 KiB) copied, 0.00160452 s, 6.4 MB/s

$ ls -lt ddtest

-rw-r--r-- 1 wogy12395 wogy12395 10240 Feb 14 15:11 ddtest
```

> tar

파일 압축

tar -cvzf 타르볼파일명 디렉토리명/파일명

-       -c : 새로운 타르볼 생성
        -v : 압축 과정 출력
        -z : gzip 으로 압축
        -f : 파일명 명시적으로 지정

파일 압축 해제
- tar -xvzf 타르볼파일명

압축 파일 확인

- tar -tf

```
# 샘플 파일 만들기
$ touch new{1..3}

# 파일 압축하기
$ tar -czvf new.tgz ./new{1..3}

# 파일 압축 내용 확인하기
$ tar -tf new.tgz

# 파일 압축 해제하기
$ tar -xvzf new.tgz
```