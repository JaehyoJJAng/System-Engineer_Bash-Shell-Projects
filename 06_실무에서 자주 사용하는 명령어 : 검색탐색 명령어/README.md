> find

:  지정한 파일명 또는 정규표현식을 이용하여 파일을 검색

```
$ find /home/wogy12395/01_test_python -iname "main.py" -f -exec sh -c "python3 {}" \;

$ find / -iname "index.*"
```

> which

: 환경변수 PATH 에 등록된 디렉토리에 있는 명령어를 찾아주는 도구

```
$ which ls
$ which cd
$ which docker-compose
```

> grep

- 텍스트 검색 기능 도구

- 파일이나 표준 입력을 검색하여 지정한 정규 표현식과 맞는 줄을 출력

```
$ ps aux | awk '{print $2}' | grep -v "[A-Z]"

$ ps aux | grep -i "chrome*"

# ps aux | grep -v "grep"
```