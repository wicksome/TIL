# Stashing

> 워킹 디렉토리에 unstaged 파일들을 백업하고 워킹디렉토리를 HEAD의 상태로 변경하는 것

## 1. git status
연재 작업중인 파일을 Stash에 저장한다.

## 2. git stash list
스택에 저장된 Stash를 확인한다.

## 3. git stash apply
현재 작업에 Stash를 적용한다. 스택에 여러 Stash가 있을 경우 이름을 넣어줄 수도 있다. 없으면 가장 최근의 Stash를 적용한다.

Git은 Stash를 적용할 때 Stash 상태였던 파일을 자동으로 다시 Staged 상태로 만들어 주지 않는다. 그래서 `--index` 옵션을 주어야 Staged 상태까지 복원된다.

```
$ git stash apply
$ git stash apply --index
```

## 4. git stash drop
stash를 제거한다.

```
$ git stash drop stash@{0}
$ git stash pop # Stash를  적용하고 바로 스택에서 제거해준다.
```

## 5. Stash 되돌리기
Stash를 이용해서 패치를 만들고 그것을 거꾸로 적용한다.

```
$ git stash show -p stash@{0} | git apply -R
$ git stash show -p | git apply -R # 명시하지 않으면 최근의 Stash를 사용한다.
```

**_tip._** `stash_unapply`라는 alias를 만들어서 사용할 수 있다.
```
$ git config --global alias.stash-unapply '!git stash show -p | git apply -R'
$ git stash apply
$ #... work work work
$ git stash-unapply
```

## 6.Stash를 적용한 branch 생성
stash를 만들고 다른 브랜치에서 한동안 작업하다가 stash를 적용하려고 할때 충돌이 일어날 수 있다. 이 경우에 `git stash branch`를 실행하여 stash를 만들 당시의 브랜치를 만들고, 또 다른 새로운 브랜치를 만들어 이곳에 적용한다. 그리고 성공하면 tash를 삭제한다.

```
$ git stash branch test-branch
```



**_참고_**
- [git doc](https://git-scm.com/book/ko/v1/Git-%EB%8F%84%EA%B5%AC-Stashing)
- [git stash 사용하기](https://blog.outsider.ne.kr/788)
