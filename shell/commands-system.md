# 시스템 관련 정보 확인

## Load Average

```sh
$ uptime
```

## CPU Info

```sh
$ cat /proc/cpuinfo # cpu info
$ cat /etc/*release* # Check centOS version
$ sysctl -a | grep machdep.cpu # osx
```

## 디렉토리 사용 현황

> du - **d**isplay disk **u**sage statistics

```sh
$ du
$ du -h # Human-readable
```

## 디스크 사용 현황

> df - **d**isplay **f**ree disk space

```sh
$ df -h # Human-readable
```

## 실행 프로세스 확인

> ps - **p**rocess **s**tatus

```sh
# 실행중인 프로세스 확인, 갯수(e: 모든 프로세스, f: full listing)
$ ps -ef | grep 'httpd'
$ ps -ef | grep 'httpd' | wc -l
```

## 프로세스 종료

> kill

```sh
# 특정 프로세스 pid로 kill하기
$ sudo kill $(ps -ef | awk '/NAME/ {print $2}') # NAME에 정규식 가능
```

## 포트 확인

> lsof - **l**i**s**t **o**pen **f**iles

```sh
# 열린 포트 확인
$ lsof -i:포트번호
$ lsof -n -i4TCP:포트번호 | grep LISTEN
$ lsof -i -P | grep -i "listen"
# 참고: http://thswave.github.io/mac/2015/05/10/mac-port-kill.html
```