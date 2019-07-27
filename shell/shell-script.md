# Shell Style Guide

https://google.github.io/styleguide/shell.xml

# if

```sh
if [ 조건식 ]; then
    echo "case 1"
elif [ $val -eq 12 ]; then # val == 12
    echo "case 2"
else
    echo "case 3"
fi

# if 조건안에 사용자 함수 2개 사용하는 경우
if isExist $path && ! isEmpty $path; then
    echo "test"
fi
```
# test 명령어 연산자 

**_caution_**

- 조건식 앞뒤에 빈칸 반드시 넣어야 함

## `test` 명령어 주요 연산자

`man test`로 다른 연산자도 확인

> `T` is true, `F` is false.

예              | 설명
--------------- | -------------------
str = str       | str == str
str != str      | str != str
-z str          | str.length == 0
-n str          | str.length != 0
str             | str != NULL
val1 -eq val2   | val1 == val2
val1 -ne val2   | val1 != val2
val1 -gt val2   | val1 > val2
val1 -ge val2   | val1 >= val2
val1 -lt val2   | val1 < val2
val1 -le val2   | val1 <= val2
val1 -a val2    | val1 && val2
val1 -o val2    | val1 || val2
-d file         | 디렉토리라면 true
-e file         | 파일이 존재하면 true
-f file         | 보통 파일이면 true
-L file         | 심볼릭 링크면 true
-r file         | 읽기 가능이면 true
-w file         | 쓰기 가능이면 ture
-x file         | 실행 가능이면 true
-s file         | file size > 0
file1 -nt file2 | file1이 더 최신이면 T(newer then)
file1 -ot file2 | file1이 예전 파일이면 T(older then)
file1 -ef file2 | size가 같으면 T

# loop

```sh
ITEMS=("item1" "item2" "item3")
for item in "${ITEMS[@]}"
do
    echo $item
done
```

```sh
ITEMS=("item1" "item2" "item3")
for (( index=0; index<${#ITEMS[*]}; index++ ))
do
    echo ${ITEMS[$index]}
done
```

# function

```sh
function isExist(){
    local path=$1
    if [ -f $path ]; then
        return 0 # true
    else
        return 1 # false
    fi
}
```

# 명령어 치환

`$()`

```sh
NGINX_PID=$(cat $DIR_NGINX/logs/nginx.pid)
```

# 산술연산

`$(())`

```sh
$((3 * 3))
```

# import

```sh
source ./common.sh
. ./common.sh
```

# 클립보드 값을 파일로 저장하기

```sh
# for macos
$ pbpaste > file.md
```