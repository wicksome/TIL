1. merge 
2. fast-forward merge 
3. squash merge 
4. rebase

---

## merge

- `git merge feature/other-branch`

```
Before)
A---B---C---D master
     \
      E---F---G develop

After)
A---B---C---D---M master
     \         /
      E---F---G develop
```

## fast-forward merge

```
Before)
A---B master
     \
      C---D develop

After)
A---B---C---D master, develop
```

### 발생 조건

1. `master`에서 새로운 branch(`feature/ff-merge`)를 만든다.
2. `feature/ff-merge` branch에서 작업 완료 후 commit 한다.
    (`master` branch 에는 `1.` 이후에 아무런 commit 이 없어야 한다.)
3. `feature/ff-merge` branch를 `master` branch에 commit 한다.

## squash merge

- `git merge --squash feature/squash-merge`

```
Before)
A---B---C---D master
     \
      E---F---G develop

After)
A---B---C---D---M master
     \
      E---F---G develop
```

## rebase

```
Before)
A---B---C---D master
     \
      E---F---G develop

After)
A---B---C---D---E---F---G master
     \         
      E---F---G develop
```
