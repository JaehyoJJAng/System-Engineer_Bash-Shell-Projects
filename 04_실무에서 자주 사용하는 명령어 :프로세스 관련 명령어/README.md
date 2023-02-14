> ps (Process Status)

- ps -aux
- ps -ef
- ps -ef | wc -l
- ps -axfwwwww

> pstree (Process Status Tree)

```
# pstree 없는 경우
$ sudo apt-get update
$ sudo apt-get install -y pstree

$ pstree
```

> kill

- -KILL : 프로세스 강제종료

```
$ for x in $(ps aux | grep -i "chrome*" | awk '{print $2}'); do kill -KILL ${x}; done
```