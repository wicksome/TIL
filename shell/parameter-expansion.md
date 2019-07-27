# Shell Parameter Expansion

```bash
"${parameter}"
```

- [Bash Reference Manual - 3.5.3 Shell Parameter Expansion](https://www.gnu.org/software/bash/manual/bashref.html#Shell-Parameter-Expansion)
- Relations(shellcheck)
    - [SC2006](https://github.com/koalaman/shellcheck/wiki/SC2006) Use $(STATEMENT) instead of legacy \`STATEMENT\`
    - [SC2086](https://github.com/koalaman/shellcheck/wiki/SC2086) Double quote to prevent globbing and word splitting.


- `${param-$default}`: param이 정의되지 않았을 때, default 사용 
- `${param:-$default}`: param이 정의되지 않았거나 null일 경우, default 사용 
- `${param=$default}`: param이 정의되지 않았을 때, param에 default값 대입
- `${param:=$default}`: param이 정의되지 않았거나 null일 경우, param에 default 대입
- `${param+$default}`: param이 선언되었고 값이 정의되어 있을 때, default 사용
- `${param:+$default}`: param이 선언되었고 값이 null일 때, default 사용
- `${param?error_msg}`: param이 없을 경우 error_msg 표시하고 리턴 코드 1을 내며 스크립트 즉시 종료

