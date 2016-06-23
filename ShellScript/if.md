# if

```sh
if [ 조건식 ]; then
	echo "case 1"
elif [ $val -eq 12 ]; then # val == 12
	echo "case 2"
else
	echo "case 3"
fi
```

**_caution_**

- 조건식 앞뒤에 빈칸 반드시 넣어야 함

| 조건식            | 설명 					|
|---------------- |------------------------	|
| str = str       | str == str 				|
| str != str      | str != str 				|
| -z str          | str.length == 0 		|
| -n str          | str.length != 0 		|
| str             | str != NULL 			|
| val1 -eq val2   | val1 == val2 			|
| val1 -ne val2   | val1 != val2 			|
| val1 -gt val2   | val1 > val2 			|
| val1 -ge val2   | val1 >= val2 			|
| val1 -lt val2   | val1 < val2 			|
| val1 -le val2   | val1 <= val2 			|
| val1 -a val2    | val1 && val2 			|
| val1 -o val2    | val1 || val2 			|
| -d file         | 디렉토리라면 true 			|
| -e file         | 파일이 존재하면 true 		|
| -f file         | 보통 파일이면 true 			|
| -L file         | 심볼릭 링크면 true 			|
| -r file         | 읽기 가능이면 true 			|
| -w file         | 쓰기 가능이면 ture 			|
| -x file         | 실행 가능이면 true 			|
| -s file         | file size > 0 			|
| file1 -nt file2 | file1이 더 최신이면 true 	|
| file1 -ot file2 | file1이 예전 파일이면 true 	|
| file1 -ef file2 | size가 같으면 true 		|