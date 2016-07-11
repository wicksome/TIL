# 명령어

```shell
# 실행중인 프로세스 확인, 갯수(e: 모든 프로세스, f: full listing)
$ ps -ef | grep 'httpd'
$ ps -ef | grep 'httpd' | wc -l
 
# 열린 포트 확인
$ lsof -n -i4TCP:포트번호 | grep LISTEN
$ lsof -i -P | grep -i "listen"
# 참고: http://thswave.github.io/mac/2015/05/10/mac-port-kill.html
 
# 명령어어의 경로 확인
$ whereis 명령어
 
# 복사
$ cp -r 디렉토리 이동될디렉토리
 
# 링크
$ ln -s [원본] [타겟]	# 심볼릭 링크 == 바로가기
$ ln [원본] [타겟]		# 하드링크
 
# 텍스트에디터로 실행하기
$ open -a TextWrangler 파일명
 
# 문자열 찾기
$ grep -r 문자열 ./*
					  
# 아파치
$ httpd -k start|stop|restart
 
# 트리
$ tree . -L 2 -d # 현재디렉토리, 뎁스 2, 디렉토리만

$ scp -p [port] -r (하위 모두 복사) 계정@원격주소:경로및파일
```

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

# date

미래는 `ago`를 지우면 됨

```sh
$ date --date='tomorrow'		# 내일
$ date -d 'yesterday'			# 어제
$ date -d '1 day ago'			# 1일 전 = 어제
$ date -d '2 days ago'			# 2일 전
$ date -d '1 week ago'			# 1주일 전
$ date -d '2 month'				# 1달 후
$ date -d '3 year'				# 3년 후
$ date -d '10 second'			# 10초 후
$ date -d '20 minute'			# 20분 후
$ date -d '30 hour'				# 30시간 후
$ date -d '3 year 7 month'		# 3년 7개월 후

$ date -d 'this friday'			# 이번주 금요일
$ date -d 'last monday'			# 지난 월요일
$ date -d 'next tuesday'		# 다음 화요일

# 2010년 1월 3일 7시 32분 10초를 기준으로 2일 5시간 17분후
$ date -d '2010-01-03 07:32:10 + 2 day 5 hours 17 minute'	

$ date -d '2 day ago' '+%Y-%m-%d %H:%M:%S'	# 2016-06-21 14:03:52
$ date -d '30 day ago' +%y%m%d 				# 160524
```

# du
> 디스크 사용 현황 보기

