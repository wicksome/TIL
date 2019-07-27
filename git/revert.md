- 현재 작업들을 모두 지워버릴 때 - `git checkout HEAD -- <files...>`
- 이전 커밋으로 되돌릴 때 - `git reset HEAD~`


# Resetting vs. reverting

- `git revert`는 단일 커밋을 undo하는 것. 즉, 이전 상태로 되돌아 가는 것이 아니며, 이러한 동작은 `git reset`이다.
- `revert`는 `reset`과 비교하여 2가지 장점이 있다.
  1. **프로젝트 히스토리를 변경하지 않는다.** 그러므로 remote의 commit에 대해서 "safe"한 작업을 한다.
  2. **히스토리에서 임의의 개별 commit을 대상으로 revert가 가능하다.** 반면, `reset`은 현재 commit을 뒤로만 되돌린다.

![atlassian-git-revert](https://wac-cdn.atlassian.com/dam/jcr:a6a50d78-48e3-4765-8492-9e48dec8fd2f/04%20(2).svg?cdnVersion=483)


## Reference
- [Git Revert - Atlassian](https://www.atlassian.com/git/tutorials/undoing-changes/git-revert)
- [git-revert docs](https://git-scm.com/docs/git-revert)
- [Git 내부 구조를 알아보자 (1) - 기본 오브젝트](https://medium.com/happyprogrammer-in-jeju/git-%EB%82%B4%EB%B6%80-%EA%B5%AC%EC%A1%B0%EB%A5%BC-%EC%95%8C%EC%95%84%EB%B3%B4%EC%9E%90-1-%EA%B8%B0%EB%B3%B8-%EC%98%A4%EB%B8%8C%EC%A0%9D%ED%8A%B8-81b34f85fe53)