# tail-color

## 1
  
```shell
$echo "INFO" | awk '
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
