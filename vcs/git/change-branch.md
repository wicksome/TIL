원격 브랜치를 로컬에 생성할 때

```bash
$ git remtoe update
$ git branch -r 
  origin/develop
  origin/master
$ git branch -a
  * develop
  master
  remotes/origin/develop
  remotes/origin/master
$ git checkout -t origin/develop # develop으로 브랜치 생성됨
$ git branch -d master # master 브랜치 삭제
```