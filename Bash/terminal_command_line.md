# 명령어

```shell
# 실행중인 프로세스 확인, 갯수(e: 모든 프로세스, f: full listing)
$ ps -ef | grep 'httpd'
$ ps -ef | grep 'httpd' | wc -l
 
# 열린 포트 확인
$ lsof -n -i4TCP:포트번호 | grep LISTEN
# 참고: http://thswave.github.io/mac/2015/05/10/mac-port-kill.html
 
# 명령어어의 경로 확인
$ whereis 명령어
 
# 복사
$ cp -r 디렉토리 이동될디렉토리
 
# 링크
$ ln -s 원본경로,이름 타겟경로,이름 # 심볼릭 링크 == 바로가기
$ ln 원본경로 타겟경로 # 하드링크
 
# 텍스트에디터로 실행하기
$ open -a TextWrangler 파일명
 
# 문자열 찾기
$ grep -r 문자열 ./*
					  
# 아파치
$ httpd -k start|stop|restart
 
# 트리
$ tree . -L 2 -d # 현재디렉토리, 뎁스 2, 디렉토리만
```

# find

```shell
# 파일 검색
$ find 경로 -name "파일명"
 
# 디렉토리 검색(특정타입 검색)
## b(블록특수파일), c(문자특수파일), d(디렉토리), f(일반파일), l(심볼릭링크), p(이름있는 파이프파일), s(소켓)
$ find 경로 -name "디렉토리명" -type d
 
# 특정 디렉토리 제외하고 검색
## \(, \)의 앞뒤에 공백 필수
$ find / ! \( -path '/private' -prune \) -name "파일명"
```
