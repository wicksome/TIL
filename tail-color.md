# tail-color

## 1
  
> 모두 출력되면서 특정 단어만 하이라이팅
  
```shell
$echo "INFO" | awk '
{ handled = 0 }
/Exception/ {print "\033[1;31m" $0 "\033[0;39m"; handled = 1}
/WARN/ { if (!handled) print "\033[31m" $0 "\033[39m"; handled = 1}
/INFO/ { if (!handled) print "\033[32m" $0 "\033[39m"; handled = 1}
{ if (!handled) print "\033[39m" $0 "\033[39m"}
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

## Color

```shell
# Regular
colours["Black"]="\033[0;30m"
colours["Red"]="\033[0;31m"
colours["Green"]="\033[0;32m"
colours["Yellow"]="\033[0;33m"
colours["Blue"]="\033[0;34m"
colours["Purple"]="\033[0;35m"
colours["Cyan"]="\033[0;36m"
colours["White"]="\033[0;37m"
#Bold
colours["BBlack"]="\033[1;30m"
colours["BRed"]="\033[1;31m"
colours["BGreen"]="\033[1;32m"
colours["BYellow"]="\033[1;33m"
colours["BBlue"]="\033[1;34m"
colours["BPurple"]="\033[1;35m"
colours["BCyan"]="\033[1;36m"
colours["BWhite"]="\033[1;37m"
# High Intensity
colours["IBlack"]="\033[0;90m"
colours["IRed"]="\033[0;91m"
colours["IGreen"]="\033[0;92m"
colours["IYellow"]="\033[0;93m"
colours["IBlue"]="\033[0;94m"
colours["IPurple"]="\033[0;95m"
colours["ICyan"]="\033[0;96m"
colours["IWhite"]="\033[0;97m"
# Bold High Intensity
colours["BIBlack"]="\033[1;90m"
colours["BIRed"]="\033[1;91m"
colours["BIGreen"]="\033[1;92m"
colours["BIYellow"]="\033[1;93m"
colours["BIBlue"]="\033[1;94m"
colours["BIPurple"]="\033[1;95m"
colours["BICyan"]="\033[1;96m"
colours["BIWhite"]="\033[1;97m"
```
