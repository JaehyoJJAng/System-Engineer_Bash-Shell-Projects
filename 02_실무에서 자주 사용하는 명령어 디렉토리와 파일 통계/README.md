> ### mount

- 디스크 장치를 표시하거나 가상 파일 시스템으로 지정한 디렉토리 연결

```
$ mount -t hostname ipaddress:/path /dst_path

$ mount -t nfs 172.16.1.1:/nfs /mnt
```


> ### stat

- 지정한 파일의 파일통계 출력

```
$ stat main.sh

  File: main.sh
  Size: 163       	Blocks: 8          IO Block: 4096   regular file
Device: 801h/2049d	Inode: 659833      Links: 1
Access: (0700/-rwx------)  Uid: ( 1000/wogy12395)   Gid: ( 1001/wogy12395)
Access: 2023-02-14 14:45:39.247650994 +0900
Modify: 2023-02-14 14:45:39.219649095 +0900
Change: 2023-02-14 14:45:39.219649095 +0900
 Birth: 2023-02-14 14:41:54.248378750 +0900
```


