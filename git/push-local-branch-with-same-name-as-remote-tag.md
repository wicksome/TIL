# git push local branch with same name as remote tag

## Problem

```sh
$ git push origin master same-tag-name-branch
error: dst refspec same-tag-name-branch matches more than one.
error: failed to push some refs to 'https://github.com/wicksome/test.git'
```

## Solution

git에서 커밋을 나타내는 포인터는 태그와 브랜치가 같다. 그러므로 push할 때 브랜치를 명확하게 표시한다(`refs/heads`). 태그는 브랜치와 달리 가르키는 커밋을 바꿀 수 없는 이름이므로 checkout 할 수 없고, 브랜치가 없으므로 commit, push 할 수 없다.

```sh
# push to remote
$ git push origin refs/heads/same-tag-name-branch
# delete remote branch
$ git push origin :refs/heads/same-tag-name-branch
$ git push origin --delete refs/heads/same-tag-name-branch
```

**참고: refs 디렉토리 구조**

```sh
$ tree -L 3 ./refs
./refs
├── heads
│   ├── same-tag-name-branch
│   └── master
├── remotes
│   └── origin
│       └── master
└── tags
    └── same-tag-name-branch
```

### re-tagging issue

```sh
$ git log
  * 6839986 - test commit - Yeongjun.Kim (HEAD -> same-tag-name-branch origin/same-tag-name-branch)
  * 9c6bcfa - test commit - Yeongjun.Kim
  * 7eb6793 - tag commit - Yeongjun.Kim (tag: same-tag-name-branch, origin/master, master)
  * 7eb6793 - first commit - Yeongjun.Kim
```

> 같은 이름의 태그가 존재하는 브랜치에 커밋을 한 뒤, 다시 태깅하려고 할 때 발생하는 이슈

위와 같은 상태에서 아래처럼 `same-tag-name-branch`로 태깅하면 `same-tag-name-branch` 태그에서 태깅된다.

```sh
$ git tag same same-tag-name-branch
$ git log
  * 6839986 - test commit - Yeongjun.Kim (HEAD -> same-tag-name-branch origin/same-tag-name-branch)
  * 9c6bcfa - test commit - Yeongjun.Kim
  * 7eb6793 - tag commit - Yeongjun.Kim (tag: same, tag: same-tag-name-branch, origin/master, master)
  * 7eb6793 - first commit - Yeongjun.Kim
```

그러므로 태그와 브랜치가 같은 이름으로 존재할 경우, 태깅할 때도 명확하게 브랜치를 적어야 한다.

```sh
$ git tag same refs/heads/same-tag-name-branch
$ git log
  * 6839986 - test commit - Yeongjun.Kim (HEAD -> same-tag-name-branch tag: same, origin/same-tag-name-branch)
  * 9c6bcfa - test commit - Yeongjun.Kim
  * 7eb6793 - tag commit - Yeongjun.Kim (tag: same, tag: same-tag-name-branch, origin/master, master)
  * 7eb6793 - first commit - Yeongjun.Kim
```


- https://stackoverflow.com/questions/9378760/git-push-local-branch-with-same-name-as-remote-tag
- https://git-scm.com/book/ko/v2/Git%EC%9D%98-%EA%B8%B0%EC%B4%88-%ED%83%9C%EA%B7%B8
