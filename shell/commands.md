## 시간 관련

```sh
# 미래는 ago를 지우면 됨
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

## etc

```sh
# 텍스트에디터로 실행하기
$ open -a TextWrangler 파일명

# 아파치
$ httpd -k start|stop|restart
```

초당 TIME_WAIT 소켓 개수 확인

```sh
$ while true; do echo "$(date) :: $(ss -tanop | grep -E "TIME-WAIT.*:11001" | wc -l)"; sleep 1; done
```

**액세스로그에서 request별로 통계내기**

```sh
$ cat 액세스파일 | awk '{print $7} | sort | uniq -c | sort
# 서비스별로 확인($2가 서비스를 나타낼 경우)
$ cat 액세스파일 | awk -F '/' '{print $2$3} | sort | uniq -c | sort
```

**액세스로그에서 시간별 request별로 통계내기(분 단위로 상위 30개)**

```
[25/May/2018:17:10:08 +0900] 127.0.0.1 - - - "GET /v2/api/address HTTP/1.0" 200 127 "chrome/2.3.3
[25/May/2018:17:11:08 +0900] 127.0.0.1 - - - "POST /mobile/api/device HTTP/1.0" 200 81 "chrome/2.3.2
[25/May/2018:17:11:08 +0900] 127.0.0.1 - - - "GET /v2/api/mail HTTP/1.0" 200 556 "chrome/2.3.2
[25/May/2018:17:12:08 +0900] 127.0.0.1 - - - "GET /v2/api/mail HTTP/1.0" 200 541 "chrome/2.3.2
[25/May/2018:17:12:08 +0900] 127.0.0.1 - - - "GET /v2/api/mail HTTP/1.0" 200 565 "chrome/2.3.2
[25/May/2018:17:12:08 +0900] 127.0.0.1 - - - "POST /mobile/api/device HTTP/1.0" 200 81 "chrome/2.3.2
[25/May/2018:17:20:08 +0900] 127.0.0.1 - - - "POST /mobile/api/device HTTP/1.0" 200 81 "chrome/2.2.9
```

```sh
cat access.log | grep 2018:17:1 | awk '{split($1,date, /\/|:/);$1=date[3]":"date[4]":"date[5];print $1" "$8}' | sort | uniq -c | sort -r | head -n 30
```
