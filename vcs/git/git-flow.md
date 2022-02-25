# git flow

> git-flow are a set of git extensions to provide high-level repository operations for Vincent Driessen's branching model.
> Driessen의 브랜칭 모델


## branch
**_master_**
- 최종 릴리즈한 안정화 버전**(항상 존재)**

**_develop_**
- 다음 릴리즈를 위해 개발중인 최신 버전**(항상 존재)**

**_feature_**
- 특정 기능 개발을 위한 branch
- develop에서 가져오고, develop로 머지한다(머지하고 feature 브랜치는 삭제한다).
- 일반적으로 로컬에서만 유지한다.

**_release_**
- 릴리즈 점검을 위한 branch
- develop에서 가져오며, develop와 master 브랜치로 머지한다.

**_hotfix_**
- 긴급 버그 픽스를 위한 branch

**_support_**
- 버전 호환성 문제 처리를 위한 branch

## plugin
**_git-flow_** (OS X)

```shell
# install
$ brew install git-flow

# 초기화하고 master, develop 브랜치 생성
$ git flow init

# feature/is01 브랜치 생성하고 체크아웃
$ git flow feature start is01

# feature/is01 브랜치를 develop 브랜치에 머지하고, 브랜치 삭제
$ git flow feature finish is01

# 이미 origin 에 존재하는 feature/is01 브랜치를 가져오고 체크아웃
$ git flow feature track is02
```

**_Intellij_**

plugin - `Git Flow Integration`

## 참고
- https://github.com/nvie/gitflow
- http://danielkummer.github.io/git-flow-cheatsheet/index.ko_KR.html
- http://ohgyun.com/402
