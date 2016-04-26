# tail-color

## 1
  
> 모두 출력되면서 특정 단어만 하이라이팅
  
```shell
$echo "INFO" | awk '
{print "\033[39m" $0 "\033[39m"}
/INFO/ {print "\033[32m" $0 "\033[39m"}
/Exception/ {print "\033[31m" $0 "\033[39m"}
'
```

## 2

```shell
$echo "test" | grep --color=auto test
$echo "test" | grep --color=always test
$echo "test" | grep --color=never test
```

## 3

> 모두 출력되면서 특정 단어만 하이라이팅

```shell
$echo "test" | grep --color -E '^|test|INFO'
```
