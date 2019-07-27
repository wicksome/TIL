# find 

```sh
# 파일 검색
$ find 경로 -name "파일명"

# 디렉토리 검색(특정타입 검색)
## b(블록특수파일), c(문자특수파일), d(디렉토리), f(일반파일), l(심볼릭링크), p(이름있는 파이프파일), s(소켓)
$ find 경로 -name "디렉토리명" -type d

# 특정 디렉토리 제외하고 검색
## \(, \)의 앞뒤에 공백 필수
$ find / ! \( -path '/private' -prune \) -name "파일명"
```

# grep

> grep - file pattern searcher

```sh
# 내용 검색
$ grep -r "문자열" ./*

# 압축된 파일에서 내용 검색(.gz)
$ zgrep [keyword] [fileName]
```

## 키워드 추출하기

문자열 사이의 특정 단어/문자 추출하기

***data:***

```
service-web.conf
service-mobile.conf
```

***command:***

```sh
# -o: only matching
# -P: perl regexp
$ ps -ef | grep -o -P '(?<=service-\/).*(?=\/conf)'

# catalina-base/{keyword}/conf
$ ps -ef | grep -o -P '(?<=catalina-base\/).*(?=\/conf)'
```

***result:***

```bash
web
mobile
```

## 특정 http status 제외하기 

```bash
$ cat access_log | grep -Ev " (200|302|304|408|204) "
$ cat access_log | egrep -v " (200|302|304|408|204) "
```

# 명령어 경로 확인

```sh
$ whereis 명령어
```

# 현재 실행중인 컴포넌트 확인

```sh
$ jps -v | grep -o -P '(?<=base\/)[a-zA-Z_]+(?<!\/)' | sort | uniq
```
