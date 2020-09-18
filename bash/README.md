# 로그 보기 관련

```bash
# 대용량 로그 나눠서 보기
more # 'more' is old utility
less

# less 옵션
less -N # 라인 넘버

# 정규식
grep -E # --extended-regext

# 조건 제외하기
grep -v # --invent-match

# 갯수 구하기
wc -l
```

# 탐색

```bash
$ tree
$ tree 

$ du -h -d 1 # depth 1
$ du -sh # --sumarize 현재 디렉토리 totoal

```

# 시스템 관련

```bash
# 운영체제 확인
$ cat /etc/*-release | uniq
CentOS release 7.x (Final)
...

$ uname -m
x86_64

# IP 확인
$ ip a
$ ifconfig
$ echo $(ip -4 a show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# 열린 포트 보기
$ lsof -i -P | grep -i "listen"

# 열린 포트 보기
$ netstat -an | grep -i listen

# 특정 포트를 사용중인 프로세스 보기
$ lsof -i :8080

# 데몬관리
$ systemd # 대부분 이걸로 사용한다
$ systemctl # systemd를 컨트롤하는 명령어
```

# 찾기

```bash
ag 키워드

# 특정 명령어의 위치
# 현재 사용하고 있는 명령어 실행 파일 위치
which httpd
which -a httpd

# 명령어의 실행파일(바이너리), 소스, man 페이지 위치 찾기
whereis
```

# 압축

```bash
# -c tar 압축
# -p 파일 권한 저장
# -v --verbose
# -f 파일이름 지정
# -C 경로지정
# -x tar 압축해제
# -z gzip으로 압축하거나 해제

# 압축하기
tar -cvf [file.tar] [folder]
tar -zcvf [file.tar.gz] [folder]

# 압축풀기
tar -xvf [file.tar]
tar -zxvf [file.tar.gz]
```

# SSH

```bash
$ ssh-keygen
$ ssh-copy-id
```

[리눅스 명령어](https://www.notion.so/783c9c4f09fc457bb2f63ea4ed733172)

# transfer files

```bash
scp kyz1018@ncon1.nhnsystem.com:/home1/kyz1018/
```

[yonchu/ranking-shell-history](https://github.com/yonchu/ranking-shell-history)
