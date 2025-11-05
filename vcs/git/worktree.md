# worktree

- https://git-scm.com/docs/git-worktree

```bash
$ git worktree list
$ git worktree add ../claude-code # 해당 위치에 디렉토리 생성되고, 디렉토리명으로 브랜치 생성됨
$ git worktree remove claude-code
```

## Etc

```bash
# 내가 작성한 PR 전체 확인하기
$ gh search prs \
  --author "@me" \
  --state open \
  --owner <organization> \
  --json title,url,repository \
  --jq '.[] | "\(.repository.name) | \(.title) | \(.url)"'
```
