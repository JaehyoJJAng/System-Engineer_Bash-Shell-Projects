> # 정규표현식

| 메타문자 | 의미 | 매칭 가능한 문자열 | 
| :--: | :--------------------------: | :--: 
| A* | A다음에 0개 이상의 문자를 매칭 | A Aa Abc A13cg ...
| A? | A다음에 1개의 문자를 매칭 | Aa Ab Ac A1 Az ...
| ^A | A로 시작하는 문자열 | Abcde Avoid Attack ...
| A$ | A로 끝나는 문자열 | A bA cdgdA abcdgeA ... 
| A|B | A 또는 B가 있음을 의미 | C[A|B]f : cAf cBf
| [a-z] | a부터 z까지 알파벳의 범위를 매칭 | a b c d e ...
| [A-Z] | A부터 Z까지 알파벳의 범위를 매칭 | A B C D E ...
| [0-9] | 0부터 9까지 숫자의 범위를 매칭 | 1 2 3 4 5 ...
| [^0-9] | 0부터 9까지의 숫자를 제외한 모든 범위 매칭 | ABC abc 에이비씨 ^$#@ ...




### find 명령어 응용하기 (-iname 옵션)

```
$ find . -type f -iname "*.py"

$ find . -type d -iname "python*"
```

### txt 다음 숫자가 하나 있는 파일 찾기

```
$ find . -type f -iname "txt?"

./options/txt5
./options/txt1
./options/txt3
./options/txt2
./options/txt4
```

### txt 또는 tzt 파일 찾기

```
$ find . -type f -iname "t[x|z]t"

./options/tzt
./options/txt
```

### 특정 범위의 파일 찾기


```
$ find . -type f -iname "txt[0-9]"

$ find . -type f -iname "txt[0-9][0-9]"

$ find . -type f -iname "txt[^0-9]"
```

### sed 명령어 활용하기 : 3번째 문장 전체 출력하기

- sed -n 옵션은 출력을 명시해주어야 함 (/express/p)

```
$ sed -n '/^3/p' data.txt

3.이것은 테스트 문장 입니다.
```

### sed 명령어 활용하기 : 'c' 문자열로 끝나는 스트링 출력

```
$ sed -n '/c$/p' ./txt1
```