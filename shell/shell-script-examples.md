# 009 달력을 이용해 특정 날짜의 로그 파일 삭제하기

`dialog` 명령어를 사용하면 다양한 대화형 인터페이스를 가진 shell script를 작성할 수 있다.

## install dialog

### 리눅스

```sh
$ yum install dialog # centOS
$ sudo apt-get install dialog # ubuntu
```

### mac

- dialog 명령어 소스: <http://invisible-island.net/dialog/dialog.html>

**내려받기**

`curl` 명령어는 기본값이면 표준 출력으로 내려받은 파일을 표시하므로 `-O` 옵션을 사용해서 파일로 저장

```sh
$ curl -O http://invisible-island.net/datafiles/release/dialog.tar.gz
```

**tar 아카이브 풀기**

내려받은 _dislog.tar.gz_ 파일은 gzip 형직으로 압축된 tar 아카이브(이런 소스 파일 묶음을 'tar 볼'이라고 부르기도 한다)<br>

```sh
$ tar xvzf dialog.tar.gz
```

- tar 명령어에서 자주 쓰는 옵션

옵션 | 설명
-- | -----------
x  | 풀기
v  | 풀고 있는 파일 표시
z  | gzip 필터
f  | 파일 지정

**컴파일**

- 소스 코드에 포함된 configure 스크립트를 이용해서 Makefile을 작성
- 소스 코드를 `make` 명령어로 컴파일
- 실행 파일을 `make install`로 시스템에 설치

```sh
$ cd dialog-1.3-20170509
$ ./configure
$ make
$ sudo make install
```

- `configure`와 `make`는 일반 사용자로 실행하고 `make install`만 root 권한으로 실행하는것은 실수로 시스템 전체에 문제가 생기는 것을 막기 위함
- 이것은 관습적이지만 소스 코드에서 설치하는 절차로 생각하는 좋을 것

```sh
$ ./configure --prefix=$HOME/local
```

- 설치할 곳의 기본값은 /usr/local
- configure할 때 --prefix 옵션으로 변경 가능

**설치 확인**

```sh
$ dialog --version
```

## dialog 예제 1

```sh
#!/bin/sh

# dialog 명령어로 달력 출력
# 선택한 날짜는 표준 에러 출력이므로 임시 파일에 리다이렉트
dialog --calendar "Select Date" 2 60 2> cal.tmp

# 달력 기능은 일/월/년 형식으로 출력되므로(e.g. 15/01/2015)
# 년월일로 바꿈
## -F 옵션으로 /를 구분자로 지정
date_str=$(awk -F / '{print $3$2$1}' cal.tmp)

# 취소되면 임시 파일을 삭제하고 종료
## -z 빈 문자열인가 판단해서 제거
if [ -z "$date_str" ]; then
    rm -f cal.tmp
    exit
fi

echo $date_str

# 임시 파일 삭제
rm -f cal.tmp
```

## dialog 예제 2

```sh
#!/bin/sh

dialog --yesno "Continue?" 5 40
answer=$?

if [ $answer -eq 0 ]; then
    echo "Selected: Yes"
elif [ $answer -eq 1 ]; then
    echo "Selected: No"
fi
```

## dialog 명령어의 다른 기능

자세한 사항은 `man dialog`

옵션          | 설명
----------- | ---------------------
--yesno     | Yes/No를 묻는 다이얼로그 표시
--msgbox    | [OK]를 표시하는 메시지 박스를 표시
--inputbox  | 값을 입력하는 박스 표시
--fselect   | 파일 선택 화면 표시
--dselect   | 디렉터리 선택 화면 표시
--checklist | 체크 목록 박스 표시
--radiolist | 라이더 버튼 목록 표시
--menu      | 메뉴 목록 표시

# 010 파일 압축 시 실행 상태를 표시하는 진행바 표시하기

시간이 오래 걸리는 파일 처리 등에서 화면에 진행 상태를 표시하고 싶을 때 `pv` 명령어 사용

e.g.

```sh
$ tar cf - bigfile1.bat bigfile2.dat | pv | gzip > archive.tar.gz
```

## pv

`pv` 명령어는 Pipe Viewer 약어로 파이프 처리 중 데이터 흐름을 가시화한다.

### installation

<http://www.ivarch.com/programs/pv.shtml>

```sh
$ brew install pv
```

dialog 설치하는 것처럼 할 수도 있지만 homebrew를 지원하므로 편하게 설치.

### options

pv 명령어 주요 옵션

옵션 | 의미
-- | -----------------------------------------
-a | 진행바가 아닌 파이프에 흐르는 데이터의 평균 속도를 표시
-b | 처리를 바이트 숫자만 표시하며 진행바는 표시하지 않음
-L | 파이프 전송량을 제한. 초당 전송량은 k, m, g 단위로 바이트 수 지정
-q | 조용한(quiet) 모드. -L로 전송량을 제한만 하고 싶을 때 사용
-s | 파이프에 흐르는 데이터 크기를 미리 지정. 이것으로 100% 진행바를 표시

# 020 명령어 출력 결과를 파일명에 포함해서 그 파일명을 대상으로 명령어를 실행할 때 보기 쉽게 하기

**스크립트에 명령어 치환 처리를 하고 싶을 때 어떤 방법이 있을까?**

_`hostname` 명령어를 활용해서 에러 카운트를 구하고자 할 경우_

쉘 스크립트에서 어떤 명령어 출력 결과를 그대로 스크립트에서 쉘 변수에 대입하고 싶을 때 `를 사용한다. 이것을 **명령어 치환(Command Substitution)**이라고 한다.

```sh
err_count=`grep -C "ERROR" /var/log/myapp/\'hostname\'.log`
```

위 예제와 같이 `(그레이브)를 사용한 방법은 내부에 있는 그레이브를 이스케이프해야 한다. 따라서`$()` 표기법을 추천한다.

```sh
err_count=$(grep -C "ERROR" /var/log/myapp/$(hostname).log)
```

이 방법의 장점

- 처리를 네스트하더라도 기존 명령어 치환 부분을 이스케이프하지 않아도 된다.
- 가독성
- (+) vi에서 괄호 위에 커서를 두고 % 키를 누르면 대응하는 괄호로 이동한다.

# 021 미정의 변수를 에러로 처리해서 실수 방지하기

보통 쉘 스크립트에서는 **선언되지 않은 변수를 사용해도 에러가 발생하지 않는다.**

```sh
#!/bin/bash

dirname=/myapp/work/tmpdir
rm -rf $dirname/
```

위 스크립트에서 `$dirname`을 실수해서 `$dirna`이라고 작성할 경우, 정의되지 않았으므로 빈 문자열이 되어 다음과 같이 실행된다.

```sh
rm -rf /
```

이와 같은 실수를 방지하기 위해 `set -u` 명령어를 사용한다. `set -u`를 지정하면 스크립트 내부에서 미정의 변수를 참조하려고 할 때 에러가 발생하고 실행이 중단된다.

**문제점**

명령행 인수 $1을 다루기 힘들어진다.

```sh
#!/bin/bash
set -u

echo "$1"
echo "$2"
```

_set -u 옵션을 사용하지 않는 경우_

```sh
$ ./arg-set.sh 1
1
```

_set -u 옵션을 사용하는 경우_

```sh
$ ./arg-set.sh 1
1
./arg-set.sh: line 5: $2: unbound variable
```

# 022 히어 도큐먼트에서 변수 확장하지 않고 그대로 $str처럼 표시하기

## Here Documents(히어 도큐먼트)

> '여기에 도큐먼트가 있어요'라는 의미

히어 도큐먼트란 쉘 스크립트 본체에 포함된 텍스트를 스크립트 내부 명령어 표준 입력으로 사용하는 기능이다.

```
(명령어) << (종료 문자열)
히어 도큐먼트 본체
...
(종료 문자열)
```

종료 문자열은 히어 도큐먼트 본체에 나오지 않는 문자열이면 뭐든지 상관없다. 관용적으로 END, EOT, EOF가 자주 사용된다(**EOT**, EndOfMultilineText와 같이 긴 종료 문자열을 사용하기도 한다).

히어 도큐먼트에서는 **파라미터 확장과 명령어 치환**이 일어난다. 명령어 치환을 하지 않고 그대로 출력하고 싶다면 종료 문자열을 **작은따옴표로 감싸서** 작성하면 된다. 확장을 제어하고 싶은 변수와 아닌 변수가 섞여 있다면 이스케이프해서 대응한다.

```sh
#!/bin/bash

string="Hello"
cat << EOT
$string
/$string
EOT
```

## 히어 스트링

bash에는 히어 도큐먼트(`<<`)와 닮은 히어 스트링(`<<<`)이 있다. 더 간결하게 포함된 텍스트를 쉘 스크립트에 작성할 수 있다. $ 기호를 확장하고 싶지 않다면 히어 도큐먼트와 마찬가지로 작은 따옴표를 사용한다.

```sh
#!/bin/bash

string="Hello"

cat <<< "인사 예제:
안녕하세요.
$string
니하오"
```

--------------------------------------------------------------------------------

사이트 추천: https://explainshell.com/

# 31 작업 파일 디렉터리에서 1년 이상 갱신되지 않은 파일 삭제하기

```sh
#!/bin/sh
logdir="/var/log/myapp"

# 최종 갱신일이 1년 이상된 오래된 파일 삭제
find $logdir -name "*.log" -mtime +364 -print | xargs rm -fv
```

## find

### -mtime 옵션

n 값       | 설명
--------- | --------------------------------------------------------------
-mtine -n | n일 전보다 새로운
-mtine n  | n+1일 전부터 n일 전까지
-mtine +n | n일 전보다 과거(n일에서 수시간 전인 파일은 끝자리 시간을 버려서 n일로 다루므로 실제적으로 n+1일보다 앞)

> n일 전이란 n x 24시간을 뜻함

지정 예           | 설명
-------------- | ------------------------
find -mtine -3 | 3일(72시간) 전보다 새로움
find -mtine 3  | 4일(96시간) 전에서 3(72시간) 전까지
find -mtine +3 | 4일(96시간) 전보다 과거

### -print 옵션

결과를 표준출력(stdout)으로 출력한다

### -print0 옵션

표준 출력에 전체 파일 이름을 출력하고, 마지막에 널 문자를 출력한다. 이렇게 하면 개행이나 공백문자가 포함된 파일명을 허용한다.

```sh
find $logdir -name "*.log" print0 | xargs -m rm -fv
```

그럼 `xargs`에서 `-0`옵션을 사용하면 문자열을 공백이 아닌 널로 사용한다.

## xargs

파일 목록을 인수로 받아서 임의의 명령어 실행

## rm -fv

- `-f`: 파일이 하나도 없어도 에러 발생 무시
- `-v`: 삭제한 파일명 표시

# 32 로그 파일이 엄청 많은 디렉터리에서 파일들에 명령어를 일괄 실행하기

## 문제

문제는 grep 명령어를 실행하면 에러가 발생할 만큼 많은 로그 파일이 존재할 때.

```sh
$ grep "ERROR" *.log
-bash: /bin/grep: Argument list too long
```

- 유닉스에서는 명령행 인수 상한값이 `ARG_MAX` 상수로 정해져 있다.
- 리눅스에서 `getconf` 명령어로 확인 가능
- `man execve`로 `execve(2)` 설명서를 읽어보면, `execve`는 프로그램을 실행하는 시스템 콜로 리눅스라면 `ARG_MAX` 값이 `<limits.h>`에 정의되어 있다는 등의 설명이 있음

```sh
$ getconf ARG_MAX
262144
```

## 해결방법

`ARG_MAX` 제한을 회피하려면 `find` 명령어로 파일 목록을 출력하고 `xargs` 명령어로 받아서 `grep` 실행

```sh
#!/bin/sh

logdir="/var/log/myapp"

#확장자 .log 파일에서 "ERROR" 문자열 검색
find $logdir -name "*.log" -print | xargs grep "ERROR" /dev/null
```

- `xargs` 명령어는 `ARG_MAX` 값을 넘지 않도록 인수를 적당히 나눠서 지정한 명령어를 실행한다.
    - (?) 그럼 적당히 나눠서 여러번 실행하는 건가??
- `/dev/null`은 `grep` 명령어 출력에 반드시 파일명을 포함하기 위한 처리
    - 파일수가 한개라면 파일명이 안나옴.
    - 그래서 늘 복수 개의 파일을 대상으로 실행되도록 해서 결과에 파일명이 표시되도록 한다.

# 42 처리 시작 전에 실행 권한을 확인해서 정상 동작이 가능한지 확인 후 실행하기

```sh
#!/bin/sh

start_command="./start.sh"

if [ -x "$start_command" ]; then
    $start_command
else
    echo "ERROR: -x $start_command failed.">&2
    exit 1
fi
```

## `test`, `[` 명령어

- 위 코드에서 `[`는 괄호가 아닌 `test`와 같은 명령어, `$ type [`를 입력해보면 명령어라는 것을 확인할 수 있음
- `[` 명령어는 마지막 인수로 닫는 괄호 `]`가 필요
- 조건을 판단해서 결과가 참이면 종료 스테이터스로 0을 돌려주는 명령어, 즉 if문제서는 이 종료 스테이터스에 따라 참거짓값을 판단
- 괄호는 `if test -x "$start_command"; then`과 같이 작성할 수 있음
- [test 명령어 주요 연산자](https://github.com/wicksome/TIL/blob/master/shell/shell-script.md#test-명령어-주요-연산자), 자세한 내용 및 연산자는 `man test`

## 추가

- "만약 실행 가능한 파일이면 실행한다."라는 단순한 조건은 다음과 같이 작성 가능

    ```sh
    test -x start.sh && ./start.sh
    ```

- test 명령어 여러개 사용할 경우. `-a`는 test 명령어로 AND 의미.

    ```sh
    if [ -f "$start_command" -a -x "$start_command" ]; then
    ```
    
# 43 두 파일을 비교해서 오래된 파일 삭제하기

```sh
log1="log1.log"
log2="log2.log"

filecheck() {
    if [ ! -e "$1" ]; then
    echo "ERROR: File $1 does not exist." > &2
    exit 1;
fi

filecheck "$log1"
filecheck "$log2"

if [ "$log1" -nt "$log2" ]; then
    echo "[$log1]->newer, [$log2]->older"
    rm $log2
else
    echo "[$log2]->newer, [$log1]->older"
    rm $log1
fi
}
```

- `$1`: 위치 파라미터
- 42 내용와 동일

#  44 두 디렉토리를 비교해서 한쪽에만 있는 파일 표시하기

```sh
#!/bin/sh

( cd dir1; find . -maxdepth 1 -type f -print | sort) > dir1-file.lst
( cd dir2; find . -maxdepth 1 -type f -print | sort) > dir2-file.lst

comm dir1-file.lst dir2-file.lst
```

- 임시파일을 생성하는데 원래 디렉토리로 돌아오기 위해 **서브쉘**을 사용
- `comm` 명령어는 파일을 비교하는 명령어로 두 입력 파일을 읽어서 같은 줄과 다른 줄을 각각 표시

    ```sh
    $ comm f1 f2
            1
    2
        3
            4
            5
            6
    7
    ```

    - 1열은 f1에만 있는 행 출력
    - 2열은 f2에만 있는 행 출력
    - 3열을 양쪽 공통된 행 출력

- `diff` 명령어와 다른 점: 종료 스테이터스

    `diff`

    - 두 파일이 동일하면 0
    - 차이가 있으면 1
    - 파일이 없거나 에러 발생 시 2

    `comm`
    
    - 두 파일에 차이가 있건 없건 0
    - 파일이 없거나 에러 발생시 그외의 값

# 54 윤년인지 확인하기

- 서력이 4로 나눠 떨어지면 윤년
- 단, 100으로 나눠 떨어지면 윤년이 아님
- 단, 400으로 나눠 떨어지면 윤년

```bash
#!/bin/sh

# 네 자리 년도 얻기
year=$(date '+%d')

mod1=$(expr $year % 4)
mod2=$(expr $year % 100)
mod3=$(expr $year % 400)

# if [ $mod1 -eq 0 -a $mod2 -ne 0 -o $mod -eq 0 ]; then
if [ $mod1 -eq 0 -a \( $mod2 -ne 0 -o $mod -eq 0 \) ]; then
  echo "leap year"
else
  echo "noe leap year"
fi
```

`lt`: less than
`le`: less than or equal to
`gt`: greater than
`ge`: greater than or equal to

# 55 디폴트 게이트웨이 ping이 통하는지 확인하기(리눅스)

> ping명령어로 ICMP 패킷을 송신하여 네트워크가 정상적으로 통신 가능한지 확인

디폴트 게이트웨이: 네트워크 접근 경로에서 외부 네트워크가 출입구가 되는 기기, 일반적으로 라우터가 됨

- 서버 관리 시 네트워크에 어떤 문제가 생기면 우선은 디폴트 게이트웨이에 ping을 보내서 연결을 확인
- 실패할 경우
    - 서버 설정 자체의 문제 발생(네트워크 설정을 잘못했을 경우)
    - 네트워크 경로에 문제 발생(LAN 케이블이 빠졌을 가능성 등)
    - 디폰트 게이트웨이 문제 발생(전원이 꺼졌을 가능성 등)

```bash
#!/bin/sh

# route 명령어 출력에서 디폴트 게이트웨이 얻기
gateway=$(route -n | awk '$1 == "0.0.0.0" {print $2}')

# 디폴트 게이트웨이에 ping
# -c 옵션으로 한번만 호출, 표준 출력 및 표준 에러 출력을 /dev/null로 버림
ping -c 1 $gateway > /dev/null 2>&1

# ping 종료 스테이터스로 상태 확인
if [ $? -eq 0 ]; then
  echo "Success"
else
  echo "Failed"
fi
```

- ICMP(Internet Control Message Protocol): 다른 호스트나 게이트웨이와 연결된 네트웍에 문제가 있는지 확인하기 위한 목적으로 주로 사용

# 56 디폴트 게이트웨이 ping이 통하는지 확인하기(FreeBSD/Mac)

```bash
#!/bin/sh
gateway=$(netstat -nr | awk '$1 == "default" {print $2}')
...
```

`netstat`: 현재 네트워크 접속 상태를 표시할 때 자주 사용

- `-r`: 현재 경로 테이블 표시
- `-n`: 호스트명 표시하지 않고 IP주소만 표시